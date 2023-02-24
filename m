Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756576A23B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBXVYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjBXVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:24:34 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9846F03A;
        Fri, 24 Feb 2023 13:24:20 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id b6so958123qtb.1;
        Fri, 24 Feb 2023 13:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2dyy0LSAUfyLYU6Trou16AO3o2R0x1ufXT5iLsOFwg=;
        b=eyoF0HD1VYVahpnM9pAU2BW5h+4Gx6x2QQtE2148eAsl29d7UUBYPHCJk0EO7enAMZ
         KJuxMZVe5flhlruOgu0chB+ZOXGlEoc7S4LblvJB3jaWYrbB9pqh4CGnG/nQcljCXzYi
         lpnC2QSFY5/0rCph5bGtZjOcK04gqAM1P4mz47VXmmN63ZTxGEkqezx1hokEUyBav4Ma
         B2THvT9xZqQjMEg9FXM25JQJvNQv6d/pS/xlascjH6nb03/+r6tplTs1kAQXxhsRXdGn
         YVj9U6Cykf0s5Nm8VBKSqQxj2eyxdt7Cd9GWY68LhhXUcY6aWCaWpe9EfGf6NweG5Uw+
         H02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2dyy0LSAUfyLYU6Trou16AO3o2R0x1ufXT5iLsOFwg=;
        b=vLP4MR1WzJjV787jAgUBWDFTGnPAA0pH7I2TtasaTqejMfV2buqNiwFjKqWFbAij0n
         Tjoc8pJcQLAm/X3WHyeJMNGWkhaPz91RifR8x8WpeF3WmFKd55+OlbAMlWtv47iXb38F
         KT0iJmOtswmd5J9Fg5KQiV4NeKgHIqRtgo7qQXjYDWD1XRgdcsNsj4HzJt1h6DJ6t/uG
         NxH/SheihinbnbM0yTj3UFynWZ9q9kTRZEpkpdGp6rDf02eZA/TuK6CYc2CaSp8+dfOK
         dDQApHJlFSP+Yb9aV/YMFmBGNrg0hnk047S4oD1k2tR/kj3vMa00pcNmsY+nQVoe/kFu
         178w==
X-Gm-Message-State: AO0yUKUfsiGqEy7tvycewBNkxaDDgmr2iaASovLy+30hC4mVPChKG4Lz
        xjKF7id4J+Dz3hwzVv7BeJg2YwhWr3M=
X-Google-Smtp-Source: AK7set+6OXUrjU5+b60mgTFkGtN9bqKFEZih0QShslf/6D/kqmlmscK12buYE27E/85cEiyRFVWS+A==
X-Received: by 2002:ac8:5a42:0:b0:3bf:ba6e:ac83 with SMTP id o2-20020ac85a42000000b003bfba6eac83mr6531669qta.61.1677273859378;
        Fri, 24 Feb 2023 13:24:19 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d21-20020a376815000000b0073b4a55a2d1sm11327qkc.124.2023.02.24.13.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:24:18 -0800 (PST)
Message-ID: <50db8a7d-0db1-54de-b3ab-838d88da40f5@gmail.com>
Date:   Fri, 24 Feb 2023 13:24:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_power=3a_reset=3a_brcm-kona-reset=3a_Us?=
 =?UTF-8?B?ZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, sre@kernel.org
Cc:     f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202302151452046003226@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202302151452046003226@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 22:52, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

