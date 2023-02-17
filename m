Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2469A2F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjBQAfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQAfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:35:32 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995318140
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:35:31 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 5so4026185qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dr7sPxdekubOGhXaC/Mdi8p1h+2sGJHvj1t8ebnC0dY=;
        b=nddzUPxIGeqLTtrhu9EVKCFxOtCsgdttfQBKL8jlSo3Boywb3FvOBviYqH6YNd6Ovy
         nQK4JagLMpujbYsfMkxHM74+gJP2lYYj+K/0jjQZscSlxj+iXXEHXWYiGvS79FvcnePv
         +zhjFAUjnPjnrAnPWLlQfTc12FdKwGbcs9OK3m6LgOAyyRZeVYWB75B2CpCsD5olEIXO
         vXJKTAIrd/xkW3IuSJuklIa/SZnXhSY5QhU3d0qQL5q7l5vsC0l90zleOgr3QiQX3y1Y
         q7z1o7gUu7Nc8jrv8JvW7dkKnvMhIf5ozpNZ4x+3JZCWV3EUaGpMXv/c4Z7vAEq5jhXV
         3B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dr7sPxdekubOGhXaC/Mdi8p1h+2sGJHvj1t8ebnC0dY=;
        b=F0WdbwhNUOozmj2hFyjwdQBwCFQvt2+daKW++aXzWWJPCC0kpHSvYMrNgS4X+Odm55
         0kyOFY56hpQc7ZZheQniJjyvKF5w4ZWLn2dAHp7gV3aNzp6i2R/Ajny8sqxsbqjj6WAS
         4vb8Y+32uQSe8uNfkaZDEuaCjARIltR9zrzfTQEhYDjjIoh+D6VTeLOqUD6Dqde1484r
         v/ZVaRRQZGIVYUFXm+cGJ1uK92WFa2BOw7iZYA8wzhhsCZevaDNO4jSwqysGk/IIqRjG
         lzV3OtS4xTg4Qi4x6gQ3lp7DYlEPdR2r7+6F0gC83+CVn2mrKqBas1EbdmiHd9pJGUX+
         ixMQ==
X-Gm-Message-State: AO0yUKUaQY9z3VXlbsMq34Yyi/5FSmRrsZvunsJi5Ggn9og+FJHiZKzT
        Pepu/X2pbiCUQJ0KDUTangg=
X-Google-Smtp-Source: AK7set9fOWzgg5dxOQFFZT2Mi8yNhyEndcRW+3jKrBaDc9Gq5iZjBh665zQr4Y6uPod5NHO+ujyEzw==
X-Received: by 2002:a05:622a:28b:b0:3b8:5ad9:3fe8 with SMTP id z11-20020a05622a028b00b003b85ad93fe8mr14198725qtw.48.1676594130283;
        Thu, 16 Feb 2023 16:35:30 -0800 (PST)
Received: from ?IPv6:2601:14d:4e80:336e:6940:faac:fba5:1dee? ([2601:14d:4e80:336e:6940:faac:fba5:1dee])
        by smtp.gmail.com with ESMTPSA id x1-20020ac81201000000b003b9b41a32b7sm2188523qti.81.2023.02.16.16.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 16:35:29 -0800 (PST)
Message-ID: <ab7432c0267ade5f5c07f69c5a3bf8ac3a8d421d.camel@gmail.com>
Subject: Re: [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to
 quirks
From:   Joseph Hunkeler <jhunkeler@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Feb 2023 19:35:28 -0500
In-Reply-To: <Y+7GEp06snoDjrH8@sirena.org.uk>
References: <20230216155007.26143-1-jhunkeler@gmail.com>
         <Y+5Ym5rUWLK4TOAf@sirena.org.uk>
         <224b230c5c8d3037b650602b5743bbf217369ecb.camel@gmail.com>
         <Y+7GEp06snoDjrH8@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-17 at 00:10 +0000, Mark Brown wrote:
> You'd need to resend to fix it but I'm saying there's no need for
> you to bother, I fixed it up locally.=C2=A0 Please just bear this in
> mind for future patches.

Ah now I get it. Will do.
Thank you!


