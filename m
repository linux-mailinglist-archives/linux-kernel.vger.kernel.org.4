Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D86AB969
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCFJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:13:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96612A27D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:13:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o12so35461528edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678093995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnHL5h6qkSujzp3h/BFB5agr3fvMuSC0tzihY+nqGSI=;
        b=BPS5bOWWlYZiucIVPSe9mnoQJw31wcrfqMYZ27Ip9gtW9a1U28i/eEAJFJf9hqT5An
         BVPaiOQz0sENJXALXJiQX/C8ESdzD4NAATPh1Eb0XBsqQPXj65Eu2kpUkKBGP8soneva
         ZRiqnPt8BDEKZYVbW5ZNT0xIlj/qT5gYCGDlSdDJNPOd5WiuRRDSIUqw4YhZEdwzKMQq
         I/Ymd1RiuONjwyac6Y6UW/dd8h09/sJAhPtTCLcap2wMbN6Pf4/L6wi+2B0r30/hkZTG
         yl2JNMwKYYaMdJFgyyJ44SFrCkA7NI1LPmFckgF6QR8yBzOEssHnbsUD+ii32MIrJdCX
         f3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnHL5h6qkSujzp3h/BFB5agr3fvMuSC0tzihY+nqGSI=;
        b=Cuw7saow+rqvau8mE5DQKi/nTrMDjHcJgbop2i2UWdlazlEbOMQCr59Q6rL5bv2Lue
         a6cTGPFzAaK1aXJ0R4IMjDzBEFe3hMobI31bSeU8QfEDriSImsjOgYxzEjAZamAvYXXy
         24yg6/bR0rVu6G8bnuuzxEmWNXyrhfX2nuIaps2mvNiu73NSZU/dROi2bik5tTcorcj+
         4uD4Ohy/CgDbo96mSqG5Y9+/I5L9KzyEKZvmz/MDgoFeBm1zMU7aJS/wgA/Wn5o/C0D1
         ms/2YFYkPJhi1QWN9z4DLIa+y44l+OXTUbKIEg3q4J3YztXdq7RYaWSXPc4xp3iwLaj8
         Wr3Q==
X-Gm-Message-State: AO0yUKVWjBlJPW+Mvz0bGoWcR1CJkQwfdfntDWRKg2aFBV+eZScPxsAO
        p1YK16y4HUQbXwHaAMAxfvo=
X-Google-Smtp-Source: AK7set93IVoMpLRC9HC2fzLXLSa69y6NBNULpgplajkcYjaYvTkH35a89MdScye9feryf3dzTBORHw==
X-Received: by 2002:a17:907:3f23:b0:84d:4e4f:1f85 with SMTP id hq35-20020a1709073f2300b0084d4e4f1f85mr13755196ejc.59.1678093995252;
        Mon, 06 Mar 2023 01:13:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906170f00b008c6c47f59c1sm4244971eje.48.2023.03.06.01.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:13:14 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:13:11 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciERadioD_Array
Message-ID: <7dba1dd0-3ae2-4566-a4dd-57b1f896d475@kili.mountain>
References: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
 <e8842422d34fd19592047ad821c0dbe2eb4bcdc9.1678051461.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8842422d34fd19592047ad821c0dbe2eb4bcdc9.1678051461.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:33:18PM +0100, Philipp Hortmann wrote:
> Remove empty array Rtl8192PciERadioD_Array and the code where it is used
> because it is dead code.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Same comments as for the earlier commit.

regards,
dan carpenter

