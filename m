Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF4741490
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjF1PHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:07:05 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:55358 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjF1PGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:06:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C8AF6124B;
        Wed, 28 Jun 2023 15:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45C8C433C8;
        Wed, 28 Jun 2023 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687964814;
        bh=tYONJNnGCQMJ80wSHKkNy+/9k7bcbNipagC4FIaSVh4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=fH3IUtR0gjCfGcOCNMckBP2f/Vs37X+rPVTO1uoh0Ocxu9vLx7mIfIgmE5UNXcRoM
         ogAbNleaeEMIL8vXfLUV9xsABdJYxzznt/+oUqFmmJgFQwmfr4ykUEi5VdEqL4emt1
         VBrN0WQBW8RAQNhUWwGsrd7t1QlsAWmwUIRBJveXODht9U2Z5gU0KpuSJvCl+MFffJ
         ZJ1Pg/F3xXwfFeeY29HbU7PmpVANRdsdDrdVOqc+In+rrGj/DN+DLIwgZIC5FnbX8k
         x0aRa3Iax38OyIKeajKR4UkyJWdPxg6NH7l2luXYY/3JH5xRtngl8too4lulS6neTZ
         LmMjwNWo1RHZg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-55b8f1c930eso3717093eaf.3;
        Wed, 28 Jun 2023 08:06:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDynyw2x7qiJl5b2bHVt5o/pujFI9Aq8DGoUmYWrosoO9K1MoV2/
        gkflC5YJvfSUFOVE4fxLgKNEip4oOHhE6c5cA+o=
X-Google-Smtp-Source: ACHHUZ6B52reag+L2IlplUvg6F+aLqCsIPNfwwTs1JaQRfUZzOM5Xa4xbUxzeJQ+BYca+dwvBsArZR5zC0ac59AlOQA=
X-Received: by 2002:a05:6820:396:b0:563:5542:c45 with SMTP id
 r22-20020a056820039600b0056355420c45mr5562605ooj.7.1687964813976; Wed, 28 Jun
 2023 08:06:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7a97:0:b0:4e8:f6ff:2aab with HTTP; Wed, 28 Jun 2023
 08:06:53 -0700 (PDT)
In-Reply-To: <20230628011439.159678-3-linux@treblig.org>
References: <20230628011439.159678-1-linux@treblig.org> <20230628011439.159678-3-linux@treblig.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 29 Jun 2023 00:06:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-KeNM56ecmnaDR2wA4meTqPRa=e+KT3JJkpvC9=PCeiw@mail.gmail.com>
Message-ID: <CAKYAXd-KeNM56ecmnaDR2wA4meTqPRa=e+KT3JJkpvC9=PCeiw@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs/smb: Swing unicode common code from server->common
To:     linux@treblig.org
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-28 10:14 GMT+09:00, linux@treblig.org <linux@treblig.org>:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Swing most of the inline functions and unicode tables into smb/common
> from the copy in smb/server.
>
> UniStrcat has different types between the client and server
> versions so I've not moved it (although I suspect it's OK).
ksmbd doesn't use this function. You can move it to smb_unicode_common.h.

Thanks.
