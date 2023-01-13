Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4E66A6B4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAMXLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjAMXLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:11:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D5D13F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:11:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so15979749pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jUJ94WIPh5ikZVHA3iOUrupkGpm3w48K05P1IMMtZ0=;
        b=KOHuyIf3wrIubmTiPZhpuLh3JWgWkt7Q/dY3fUBMfDsq+vTXHNA3Gvey4D+ulmk/iD
         nmkVqlruiBXxjeAy3HN1dRxLeg42wv8me5jo9J6OrZz6jpxYASFwMqqoTzxu7rgPVvbI
         w5z4SRL2h23Sjcm9g3LkLh/eYwKTESuOSSevE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jUJ94WIPh5ikZVHA3iOUrupkGpm3w48K05P1IMMtZ0=;
        b=188MsixLYES4TLAPP3Pw3xH3NaLykhJPh7rBq+TW9vONids/ZGCEs4m9Nmd6FWHmVH
         kiLMzvGUA+kGE32fnWstAFsKTd81AS6bSvJiTzNN2ahVIrw0NSdGmblvnUwGYkBKBjFT
         Zxl3DJ5kwsN7lPm3w1OmIATX/+QLPy89lYj4hQhp/QZ/vnuP0xRvRZ6Pdb8iDceJpZVb
         dz44+2yxPeeMzc7EfwqMGW9AfWMRy7Fh3uX8A574XKmcgF9q3SvbBq8rGRWmc2DvdAL3
         80QL04vdSJ3zjnUxaSBsrxIqs1Ha24I+Hd7vx5WkA00/bKax4FJftxZQK02QtnB8+XQ2
         4xRw==
X-Gm-Message-State: AFqh2koBBBToFpLy2PB81FFSngc6zkWik8be620dLDRUXClNeJ0t3SgA
        wRf8CmUxZMiYu6q0a3Wegapgv6uEAzuKKxjo
X-Google-Smtp-Source: AMrXdXsHbSJmV0JEp+K2at9d1YifIpFD9ZQv6IQN0nZHChwFC2bDCBIDPR5dNfT8yphTzZ89BVVN5w==
X-Received: by 2002:a62:3883:0:b0:580:b942:e85 with SMTP id f125-20020a623883000000b00580b9420e85mr69637025pfa.16.1673651489009;
        Fri, 13 Jan 2023 15:11:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f185-20020a6238c2000000b00575fbe1cf2esm3788240pfa.109.2023.01.13.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:11:28 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:11:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: ll_rw_block() funcation has been removed
Message-ID: <202301131510.914A394@keescook>
References: <20230113133843.ivsmaqjbf5cn2ui6@ovpn-194-184.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113133843.ivsmaqjbf5cn2ui6@ovpn-194-184.brq.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:38:43PM +0100, Lukas Czerner wrote:
> Hi,
> 
> ll_rw_block() has been removed with commit 79f597842069 ("fs/buffer:
> remove ll_rw_block() helper"), but I noticed that it's still beeing
> referenced in drivers/misc/lkdtm/core.c. I know nothing about LKDTM so I
> can't even tell whether it's a problem at all, but I though it's worth
> letting you know.

Ah-ha! Thanks. Yeah, lkdtm just has a predefined set of possible
breakpoints. I can either remove this or add something similar. Any
suggestion? (Or a patch?)

-Kees

-- 
Kees Cook
