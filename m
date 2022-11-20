Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF3631483
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 14:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKTNyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 08:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 08:54:50 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D22BE00B;
        Sun, 20 Nov 2022 05:54:49 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j6so6465708qvn.12;
        Sun, 20 Nov 2022 05:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2eBU6ujLjyRJynR0RvOp7u1Nyp2ufatO0a0XjB50bs=;
        b=Qf6h5tbxlpXEZr64yYl4hlz7wLka+FXS26VzVb8+gFuUb+oi2RoNpYpbuU65Fwzycs
         0mu8diBrFaz4yzH1+YJX923cRRwhB1jCobagLYQvPXHRFFffKOcP+3WzbH5TvaVv00u5
         0sehlNEBK6exUSLOPvrZXTTBByisRCol+uf5/emaSc3XlyzIOLds8LzW+VbP/RpPKpr0
         0y/TMZWwLwoN83TRPw6F1X9O2V7kP3BWn7W+mE2jyKCkKxH+rPqTvQkP216GVgdn1sFp
         e6ggDlELNvYMgRlqeQbtOpyMH21z8Zi0Q9oQ08lzRHWeFYw9AnRuUQ0XBPwiNU4C5yOX
         i2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2eBU6ujLjyRJynR0RvOp7u1Nyp2ufatO0a0XjB50bs=;
        b=JZjoXer5bU4oJmLcXxOZXPjY3kVeWAak2+FH1ZmTTjPkhJWyq5gf/dFGJLDgI58BLg
         wBTwtd6s5Vu2ADn9jmI7/5zj/zWjYYM8+JcZWzdSRWzM0FzkSVNspP1/l9YSjJAxaOt1
         nvObBvTLCeveUf2yb+JhUvbk7wDSytttpJTijvzVm5Z9XKwiDcAOGShzIamlAwcFtzId
         LwuH2u1DFXsf4qIfLn5AI7Z4/GUjP2FBUiQq2joaJEdV2ZLFLkyh3WVkMgriqPOGubMo
         0ojiUrIGuwBk1tv61KR6jMdjJVMpc5FN41s1xqj6RXMedX3mtly7o0I7UA04vSy4Zn3d
         BU7w==
X-Gm-Message-State: ANoB5plrf7CDGl3uIwCM5Wzx88TRyryfbsFAzzSUlJ3lVmEx9BpcRByE
        2CpNBxwAGcgk4cilR0c9me0=
X-Google-Smtp-Source: AA0mqf4wSbT3cOLHR/0uBg22tGhXq9/EKpLQkf5i1JmpcnVOFjdE/00XNQRZt8nKzczfYnEj9/E1vw==
X-Received: by 2002:a0c:c589:0:b0:4b1:af4a:5c65 with SMTP id a9-20020a0cc589000000b004b1af4a5c65mr2397651qvj.121.1668952488677;
        Sun, 20 Nov 2022 05:54:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gd10-20020a05622a5c0a00b003a5c6ad428asm5171344qtb.92.2022.11.20.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 05:54:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 05:54:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmbus core: Add power good support
Message-ID: <20221120135447.GA1787833@roeck-us.net>
References: <20221117184022.1808508-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117184022.1808508-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:40:22PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Update error flags with regulation out if regulator is on & power
> good status bit is set
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next.

Thanks,
Guenter
