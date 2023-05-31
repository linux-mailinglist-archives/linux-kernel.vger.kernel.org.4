Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F07176A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjEaGHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjEaGH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A9129;
        Tue, 30 May 2023 23:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B6363577;
        Wed, 31 May 2023 06:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226BFC433EF;
        Wed, 31 May 2023 06:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685513243;
        bh=r+uCSX0FlAx5seguD2P6anTVmMxo76ufibjreIZ+WQU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Bmu7G3tmFFXzXdxYA+SEq2xr3JUeRgpBE4xGQAqT05BGZMC1lqTcx+w05b26ymEv8
         QzUJtBOevoCnK0q5g2WeIN/7lnRW9zl/Hl5WpVb5BjcEV4F398JWmipu2oPMmp3U7k
         09t6/bqRljcE+q2WZEYkiTSsBBbmmEQn9HcDMdBhvX5sFIc+kbk+daB9WPyo2X/w/0
         5hbkCOhN7jg8+FzeF0GoJqF0Tfpi+sLyDNnvffVJp2KIV1/pt08/i5GHKh07QHK0sR
         bqKu3pp+YthKQvUg3t2XMiFLc/7mbgxrMRyYgkd21pswvSsYrVtwdVD3YA/jF2gmxz
         XSzkfjfjpRpXw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-55825988b7bso870529eaf.1;
        Tue, 30 May 2023 23:07:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDwzPzyn9ozlKJOwx5NztgAS/lnJs90sFHWpBId/Wg44JF5iEYyV
        dUfJU/acIUTc7GiqU5o+Si5TLJU71hJ4YE7UDhg=
X-Google-Smtp-Source: ACHHUZ5TLnSl+CXJbe6tswmtEJT0GKPLcvM1DH2Oq/Yl4KVtXQS22+CAuptq8iZCdAEE3Ut9ti9ajKGUsW4PrglO8UI=
X-Received: by 2002:a05:6808:1383:b0:39a:4ac8:34ae with SMTP id
 c3-20020a056808138300b0039a4ac834aemr1139847oiw.12.1685513242300; Tue, 30 May
 2023 23:07:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:acd:0:b0:4de:afc5:4d13 with HTTP; Tue, 30 May 2023
 23:07:21 -0700 (PDT)
In-Reply-To: <20230531021043.39728-1-luhongfei@vivo.com>
References: <20230531021043.39728-1-luhongfei@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 31 May 2023 15:07:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Wg3_8GUfXsfBCkGeKZBJvr+mom=a5aqYi+anokP5aSg@mail.gmail.com>
Message-ID: <CAKYAXd_Wg3_8GUfXsfBCkGeKZBJvr+mom=a5aqYi+anokP5aSg@mail.gmail.com>
Subject: Re: [PATCH] smb: Change the return value of ksmbd_vfs_query_maximal_access
 to void
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        "open list:KERNEL SMB3 SERVER (KSMBD)" <linux-cifs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-31 11:10 GMT+09:00, Lu Hongfei <luhongfei@vivo.com>:
> The return value of ksmbd_vfs_query_maximal_access is meaningless,
> it is better to modify it to void.
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
