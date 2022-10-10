Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCA5F9874
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJJGmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJJGmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:42:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF004DB4A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:42:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q1so1233974pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXPAOj9Bq+HugAJySiBu0AC58a0ELq0buEddLUN8y5w=;
        b=pUZVqdGPSMSBdRSepcB2milITj52SaRgiSDEAVYwJZx5jy3WZiLNgR4Erw6aXQ++tO
         P8BtKGl8ghEPPwFRhKGAsGitNVRAtUcf/1TjaZxvsxR/S9QZYi9x4ttxwX5bY+mYtUsc
         b+e9JfCYlBomkXBzXsPNpK2ThoBf4eCjX/YvsBvWIG67fb7WvAxdcYUTD+9Gy7QW3UHb
         C50OLhOqFpuCmRm4hS/+eaqBAoH0LtACWygcUeNF+9RkxzTRS2HlsRBoc+mnnGV64YVd
         I0WaE4vz7dK9D3WHSf4/GkDOsu6LOkLBhggIUg/RDm6Cze0q8PCX10i8HyTSBYrqMwvo
         NLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXPAOj9Bq+HugAJySiBu0AC58a0ELq0buEddLUN8y5w=;
        b=SGytC7INX5pwBozhJjQyrkZXWpx+1Kb18UeSM5SHqkET8VfgRDWVvr1TjdU0OnzKU6
         OIt3qyjDWk+3E2MD3oXEvDILz/N637ATOJuIoYIxi7GnKoobZwHvZWHXBuid006ZDBWx
         lLtouE18D66TtEedaft3FkAjYmZEZS66bchEhStk/ec+oXBTnLCV26iBt9s7ynqcJ3va
         9I3z61/LukZIT84sq8ti0fh14QnMDWQqw/XEKfXLzUZon9dWz3ccM21XoLW+NLqwbrCb
         3bCr/I4yl9YLCP7Bby/dSfdx4mrl751ZJddN9ERY5WUS7Fj1+h6Y/2WWA+ZMK5F163P+
         g11g==
X-Gm-Message-State: ACrzQf3e8hosEjv1Abeu4orsoIGDV3YHNEyArmGiMzIh1ZhjPCqTxIuV
        BALxOQWVy1Kn0KutvWmFt5WzwGe05Qk=
X-Google-Smtp-Source: AMsMyM5iL4iv2Tym+KAqhinCaYNCEs4yxAa38u/Rj1OTdPhLz9jhxZ991STIAZ11svBrcyWi2nJ+3Q==
X-Received: by 2002:a05:6a00:cd1:b0:563:8df5:2b8b with SMTP id b17-20020a056a000cd100b005638df52b8bmr66556pfv.67.1665384138693;
        Sun, 09 Oct 2022 23:42:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1bd8:541a:735e:92d5])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d88d00b00176be23bbb3sm5756343plz.172.2022.10.09.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:42:18 -0700 (PDT)
Date:   Sun, 9 Oct 2022 23:42:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: remove devm_device_add_groups() and
 devm_device_remove_groups()
Message-ID: <Y0O+xylVpBGtqmIr@google.com>
References: <20221008154310.278062-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008154310.278062-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Oct 08, 2022 at 05:43:10PM +0200, Greg Kroah-Hartman wrote:
> There are no more in-kernel users of these functions, and no drivers
> should be ever using them anyway, so remove them as they are not needed.

I still see call to devm_device_add_groups() in
drivers/soundwire/sysfs_slave.c in the latest linux-next. Once it is
gone you can add my

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
