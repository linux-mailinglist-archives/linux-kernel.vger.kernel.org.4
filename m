Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80E6A2FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBZOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:14:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DA11E9B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:14:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y11so16909plg.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oAQg12p/07ljiI4mBI5ZR7TWyWKasJobRzn1kv4e9h8=;
        b=BJkdZ1fqbDvcR8wt5DR64B/i9aiX4o4PeNbOldidF9WnLVP6y8LTFCdLrPcSDzMS7I
         Nz+q/EbV0neqif7/M4nAoyDTidVnheTui52g0bYCQt2X85vr6NDKKFgG/vpvedo2t2xd
         kd79sPaIONkq94qrS5aAET9E+gWAoTQyDO/I64EnXtW8C40gGZ03bed9XVJ5c1xkDJ57
         hIM7lf5jsFpDPZDoPmZ8ijCZq3QTmdXLpotaeCuU0d1QYTxFL8Q6w8HVZlEAAeoLeTft
         mHeojp+TRbyzgwBsVG5Ow/Nj6PyB9gUO4LJIaStEt0oY+I6geFqtCbt8ZVuZl9unXEGL
         Pw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAQg12p/07ljiI4mBI5ZR7TWyWKasJobRzn1kv4e9h8=;
        b=wolN4KHh9L61yFh3cP8q0GQe9ga4a1LsSVf+xf5M71SoG9nk+VG629HaLkwMzvSGhf
         nBH1b4+QDYts23vrKrhW3INophcCZe1Mbh+WpbSAu71ppUZXt1UoZ5oU2xrXZnX5Aiu9
         5K8pFrky71OC/zpAWo5VU5kyteaPpejKIGfjVeiEfF+WNLuQOnkjee54DrHB4HtwGY1Y
         yTBDSxSI+wSpgzOWoQYeMmmmFlgOU6341h/I86ifSAD86k5j08PHmo4LbArj2fMueXZz
         kY8wkdBmqnVQdAiAX6o1lO/FEIVHMkh3VM3xGWfyaeHUXIAUsqFcIDzKQGDx0zoTEmkJ
         7XEg==
X-Gm-Message-State: AO0yUKUTwFT/8De/9p0At198kQNPg8Eo0sfnbPOGAaW82FwVZDcsVsJY
        sANwbM5pki38eDRAT3sOmIA=
X-Google-Smtp-Source: AK7set+3tINTYEvd0acZfGwn7reu55jXetSRZrY4aQ/GR8IzpcikOCpdje8kNkdiu89FpcWs/7eMMw==
X-Received: by 2002:a17:902:da89:b0:19a:f02c:a06d with SMTP id j9-20020a170902da8900b0019af02ca06dmr26558010plx.29.1677420875038;
        Sun, 26 Feb 2023 06:14:35 -0800 (PST)
Received: from udknight.localhost ([117.30.83.133])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001967692d6f5sm2698552plb.227.2023.02.26.06.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2023 06:14:34 -0800 (PST)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 31QEEJOh032202;
        Sun, 26 Feb 2023 22:14:19 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 31QEE6mg032201;
        Sun, 26 Feb 2023 22:14:06 +0800
Date:   Sun, 26 Feb 2023 22:14:06 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     miquel.raynal@bootlin.com, bbrezillon@kernel.org, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
Message-ID: <20230226141406.GA32048@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        miquel.raynal@bootlin.com, bbrezillon@kernel.org, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230217165442.GA28288@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217165442.GA28288@udknight>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 12:58:08AM +0800, Wang YanQing wrote:
> The commit 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
> adds helper function, try_write_vid_and_data(), to simplify the code, but this
> helper function has bug, it will return 0 (success) when ubi_io_write_vid_hdr()
> or the ubi_io_write_data() return error number (-EIO, etc), because the return
> value of ubi_wl_put_peb() will overwrite the original return value.
> 
> This issue will cause unexpected data loss issue, because the caller of this
> function and UBIFS willn't know the data is lost.
> 
> Fixes: 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Hi! Miquel Raynal

What is the status about this patch?

Thanks!
