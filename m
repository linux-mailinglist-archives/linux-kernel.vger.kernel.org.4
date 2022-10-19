Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66968605337
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJSWfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJSWfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:35:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05931285F7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:35:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r17so43255784eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4g2WGpfHQynp+rFhcmOPjXRA2g+YdubJZg4hG2W5kJo=;
        b=YK6Mp9KoAJifBMVTBpjdQPsWsAQ+MADcn7Tbk17EFljc6WYgMP2Jhw87Gmds1miK1Q
         6C04jfiteJq24pgwyhPmwPRbId6Ms+FEMLhywKu1rYai+6hKJmQH00l5/W19emHa/UrK
         fWwqr206553/f8QhAEpW/HVZJ/LeJcxJSiu8qSCHk68QPtGAqC9OK0ww0nzyo14NzeFH
         v15rZ9CHDxW1AtvS+96WurNXaiAnupvUC/AmzryZ8OwJBgWiJzMvEFNo4fH4+8BtaDLl
         H1svU5GlzK8qjMfR5zjtQlK2B7fzkt2UvARjd/GwW1v5xSxya/MQzQ5UZ6tjy5lssbsR
         DRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g2WGpfHQynp+rFhcmOPjXRA2g+YdubJZg4hG2W5kJo=;
        b=xhBFJRXDD7iQ3O0DKKg/vUMui9o/2xxiQOe++L5u7I/f71ckPXuumpVydLdxmzDtzO
         +1ut8AlAbLWlwZu60QsQFe6r2uoD8KrC+1qI8Q6ZNRwQlRPnCRnNiPI321/h0XVCReKz
         weq0jssIrkMiEsV91l+FQ4//RqysASE5sE+IfwL7cXDL7OCZzFSqXIV2umn45piIZNVa
         bOBg9Mtq1L4iCPkbEliHvPN1YcbIKoQYutKPay1ZeVV3EYKWKtL8TfB0fhLZu9n/NOWm
         wfXeY5My+zTmyk8xQX/zwGj6OGP6Q0RjZJjYOfL7lmV9OUoGCzahVeMVD1+Iz1SQSCCY
         0ebQ==
X-Gm-Message-State: ACrzQf3ZWCzAba3qsjJDF00+EUHS90r2jhSFTs3p5LsxJmN4l6I9pr1v
        fgY9aKulTfOj3A5TwM4ZYEEwVWklZbE=
X-Google-Smtp-Source: AMsMyM4inb7j1xMefkrU37SzXhA3wgqBpTCz8Yjzn+mE3QBReAkA4sTQspgmI8/MI8T4Q5u8nFpdvg==
X-Received: by 2002:a17:907:6d29:b0:78d:d12d:15af with SMTP id sa41-20020a1709076d2900b0078dd12d15afmr8633082ejc.53.1666218912806;
        Wed, 19 Oct 2022 15:35:12 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id h28-20020a1709070b1c00b00780f6071b5dsm9264413ejl.188.2022.10.19.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:35:12 -0700 (PDT)
Date:   Thu, 20 Oct 2022 00:34:46 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     greg@kroah.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <20221019223446.GA154747@nam-dell>
References: <Y1BN6wPMrpxPB3qP@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1BN6wPMrpxPB3qP@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 07:20:11PM +0000, Tanjuate Brunostar wrote:
> Code style warnings reported by checkpatch.
> Improve the layout of a function header:
> Put the first parameter immediately after the '(' and align the other
> parameters underneath it.
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> 
> ---
> v2: put static and void on the same line and adjusted the indentation as
> suggested by Greg KH

I think he meant putting "static" and "void" and also function name on
the same line.

Additionally, I think your patch introduces new checkpatch problems. Did
you run checkpatch.pl on your patch?

Best regards,
Nam

