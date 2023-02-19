Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B238869C357
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBSXNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBSXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:13:36 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D253166FE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:13:35 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id b5so1514878qvp.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbnYIGH3Ny56S6wjxGfeIpC8QGmzEPrrNwSudEZl1xc=;
        b=daxxv44+upzQZwMCqpPWUNUv3ARybNL5Jo5JAr3iKX2KOGFG2eyGYA3sJd246IquT4
         sHRi8bnWYJ+ub2KZh9fcWM6eBLpbSqiRKNlaCTDDaCUkpEyrlaKlpk2FKJbkf7Ff8+70
         hVM3ARikNPmpxV26dJg8KUDJ99MeIQPtWcgIZ3rrS+pPiyoVkt7UL47SMKREtA5jMZ/O
         dcRdbPZdByGBzOVNwL5Hv3XOCjrYOQJX4/DNeEAlT3lRoVwTN/p0OVpozr3rhz4v5ual
         dwD8CMc54EzGi20EjUZ+5jyhTkHiZhtpMEh45aWvKZPitBTh3sy6IgfsWTMvGCFK992C
         q7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbnYIGH3Ny56S6wjxGfeIpC8QGmzEPrrNwSudEZl1xc=;
        b=M/Nziuj+VQthr6cmdiJM+qC4dJtVOExngArGW+8u+9UHDcohp9j4kI+DmSM//lsbVi
         10Ry4lD4KKhzpS5PllT6zIoyL/khxEDmJ+u9RpRn7qA4qWw58q+YPIFgoCR1VG8SArMD
         eL12nBE06AKKTa92GOL7N3zrrbHqCJnHabX+8scKSGFufEk5sIFUc3lqxzakMUhU9tDb
         6MoPR59JDJmSHbTdX13nMZRbxBgJsfXyhxOqYODIgT5PxaX6+H+uEflcwbfeuzEsmxcu
         H0wgwkk8y+iwf1r4lUNRCdGM7WUHhKSQvqmL3ErwUVM7+s3WOY1ZK0w5ow1J44AhRafo
         XCPA==
X-Gm-Message-State: AO0yUKVb2umy0BtOaza6F8fIxoTiQrNgVpPdUlnrxfMtP7QV5Y99GyaF
        bVGBWIbK0Y6Glx/PvrMTSuU=
X-Google-Smtp-Source: AK7set9eJ97ZzcaGqhW7rVxpyDSxVdYlo/XC1xFocOp3wVHOvCah9APjfyqE+I8qdDtChNBQmO74kA==
X-Received: by 2002:a05:6214:19cf:b0:56e:ae3c:129d with SMTP id j15-20020a05621419cf00b0056eae3c129dmr2820386qvc.0.1676848414517;
        Sun, 19 Feb 2023 15:13:34 -0800 (PST)
Received: from hotmail.com ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id m3-20020a375803000000b00725d8d6983asm8017692qkb.61.2023.02.19.15.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 15:13:33 -0800 (PST)
Date:   Sun, 19 Feb 2023 18:13:31 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug with /dev/vcs* devices
Message-ID: <Y/KtG9vK0oz0nQrN@hotmail.com>
References: <Y/KS6vdql2pIsCiI@hotmail.com>
 <7b3b85cb-1a94-5330-9236-ed192c1f4fa0@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NNXRJ0/jkNf5m2xa"
Content-Disposition: inline
In-Reply-To: <7b3b85cb-1a94-5330-9236-ed192c1f4fa0@infradead.org>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NNXRJ0/jkNf5m2xa
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Feb 19, 2023 at 02:11:00PM -0800, Randy Dunlap wrote:
>[add George and Greg]
>
>@Storm: You should always send emails directly to someone as well as to the mailing list.
>
>

Howdy Randy,

Thank you for adding the correct people. I thought I put someone in CC,
but apparently it did not work as expected. Part of the problem caused
by this bug is it causes my screen reader to behave a little strangely
sometimes. in this case, it read the CC field, but I must have put the
address in a different field, maybe bcc, or somewhere that caused it to
be dropped. Of course, it is probably a good thing, because the address
I found was not the one you added.

Thanks,
Storm


--NNXRJ0/jkNf5m2xa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmPyrRgACgkQW+ojcUPd
wZOWEA//X2R9yKcYVYoNlguX6kwlHYl0wMaaZkG5BNBAN1bQkX85BeYII6p6P3iL
ryXKY2LYIDw8NqY01lb4hnFhICpPWXweArDMOrdDAfWNHlbHyIbeCTu6c3r+oVop
bbodQ/yIqS7nDPw0iUj2k0+35AO0Wx1MKefSX7Y4eI/ofhI/4zN8Wh/Rqx6hcomP
11KPEMUcD8OS5XtZYNzc3EaGJIvXNpyrNTEaozXXa9kSIrAeOiEzKjDxqKoIBu7z
o9m6sfxDNE0sLImPqgdLbmuyUSPvQaOuJbDxX2apvSyMweQNN2PpG2+7lnxFzFX2
Bkm+gngsRU6HAmob4xWaY4L2uxqkz22Gvg7Tc05mYtMNmMxJZ/KkrtwPk1a1Bx4H
dZuSQ1hu1CAq7aFyyr0iEYJVFrWjw9fzYD31LR+cRcdMFJKg0+5muIAeLRi5zqgQ
t5+MkwveOltDksqXvKKLCJKuGnHM90PuMwv1y/udciTuAxNeazZ4/pI9QNWGtC+h
rMcofL45ph9g8TTBBEDKGrpl6cwQsExV170BMlV8PeicHq3GrJsknsW84krHLeOD
sr3Pj39L2LRQMwQ8vNiIowjP9RI13ucv+xnRllv0sqGtBxQiEs7Kj57dCUoFR5aE
5FEqZlBeO7tOKP7Sai+FXQmvxnAgC8/JHR7YGm1uA9zFVFOFVyY=
=hBNj
-----END PGP SIGNATURE-----

--NNXRJ0/jkNf5m2xa--
