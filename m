Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545D969E861
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBUTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBUTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:34:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253E244A8;
        Tue, 21 Feb 2023 11:34:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z2so6394694plf.12;
        Tue, 21 Feb 2023 11:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/17f+DzetPf5Wbn+q3zaaJ9PFuWaNoMs35ocYvK/NiU=;
        b=UZqQtVF4IiQJvFWIapVaJlYuyBGibLTENnCKujiaGZ27SONdSe0x8FzpmmPg+vOL/2
         5mgvo9NY6cTBwPDOuB6O1VWbuFieyO9VoUjv29ZlkA5y9pra93NWHwqyWnb5U+kAWOwc
         kNVqn7A3sEFTbmFaxi1veyaH1sT8KY58dQS5b/NpniVoD3BE+osE6QIeFlX8soGjWiYP
         57b0theKy9rSF7GiZtIGE/rk/zdslETukshIFm+SGU/n335ANt1EVO2CfGK9ePyn9c/g
         kCVxM5I8FwJq3qbOjkoqX2BBG6r0P7gYYLV221pB0+LcPP3RA5eTE7WJkm3qTX3WmYaG
         LwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/17f+DzetPf5Wbn+q3zaaJ9PFuWaNoMs35ocYvK/NiU=;
        b=JlDB9efotkDR+n9EF3N8azcrLBpELMAgVmpsG89Szc98WggHNDMsRvlJRyoKeZSUBq
         di/MbeKekxBH/7ORC0jHRQ3xRd8sPRzjzLjVdXcW3idS5+GeJsXNCPcJpqaK/RvNM0kG
         7NyS0Fj6Oq3/ruqTyZKYHDG2hTZ7Llrbe83BazjM0d8SYoX0epgjKZ90fJGaE36ho5JZ
         r2J8k0IPbV4+rHM3xZ8h2HaBJBSltpb/LYmtgzkPrQ3p8F/x6zPnaLB/7Rw2IDw17ph2
         /uxywki7B4q+335N2TahBO4Bal9wZcHQFH2dyExvwAOsZuJEjp+jtOIoXFRCpezollgR
         WDeQ==
X-Gm-Message-State: AO0yUKUic5WyxBReAR4LXR2Ef7OmJIfeWg4VJ2ftR93FpIDvfNdxwox6
        i+in4FfDTXa15xxBYpljc9j3MSA45NI=
X-Google-Smtp-Source: AK7set9l9NflyM40DhEq/AoNiBJJJc/LSf+EqEm0YORdySMYYlmJt6maQUBDxtXDqTsqb7F1RsK03Q==
X-Received: by 2002:a17:903:24e:b0:19c:32b1:185d with SMTP id j14-20020a170903024e00b0019c32b1185dmr7491470plh.39.1677008085520;
        Tue, 21 Feb 2023 11:34:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:30ba:90e9:a2f2:4b50])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019afb7a02a1sm9997472plb.218.2023.02.21.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:34:44 -0800 (PST)
Date:   Tue, 21 Feb 2023 11:34:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     hdegoede@redhat.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?sun4i-lr?=
 =?iso-8859-1?Q?adc-keys_-_Use=A0devm=5Fplatform=5Fioremap=5Fresource=28?=
 =?iso-8859-1?Q?=29?=
Message-ID: <Y/Uc0SMFUmgtjkcH@google.com>
References: <202302171036375639285@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302171036375639285@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 10:36:37AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to Use devm_platform_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
