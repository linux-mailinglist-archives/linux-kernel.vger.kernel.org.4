Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD26FD39C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjEJBp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA035B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74E1638A3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37CFC433EF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683683154;
        bh=B4pceyflB6O68L8oueI/kuHTf/K1LJwG3DOY6/LWUG8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lCx8TuG9BAXL9SMkd5GqaLPZIsPjvAdzoTlXhowd+P535cA/3mtfiUutG1QHgp7I+
         QEGKFin8+wBozzVLobT7xvo8TnrRzAUiaeyqmsIyQXAG+jQSzH89k4EY9BKW3UPYH9
         Ki9tVQA1yMMqlXz6tbX6D1T/ruuhzOGdrJp+4Qh+qCInWJe3YYfERwjmGrCfIzuoHs
         KqaArJVKrD62UHO1SFrO5G9v7n/3ee8rVIK/PVwIeLg5PNSQOFsjTQ0hJ4VvCs5WIa
         UyEguwsDSD3SjS2VJOtd7oIVU9n7XBVm7L+vS+Z7sXTbC9pGHn9q+f2ZvS8+wdKlsV
         t8uF+zjCyFeng==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ab0a21dd01so1084684a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 18:45:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDwz7EV+ucv889FhGUwxMNVFa3waLE2+WORtCadSa4QIXLMdykU8
        1iCgOTSP+bOsaqp0brpTJ8vUKaDtQAmmPs8VhNY=
X-Google-Smtp-Source: ACHHUZ4AwXWk6pXI3HwwQblfrMoGxRULWH1RtE+4rPsd4pxR/rNLSB0Avu9tGFxkjE8PjgBT2yTesDb7DwAHkth323g=
X-Received: by 2002:aca:130c:0:b0:394:9a9:3c7b with SMTP id
 e12-20020aca130c000000b0039409a93c7bmr1703188oii.1.1683683153133; Tue, 09 May
 2023 18:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:290:0:b0:4da:311c:525d with HTTP; Tue, 9 May 2023
 18:45:52 -0700 (PDT)
In-Reply-To: <20220813161220.6039-1-tangmin@cdjrlc.com>
References: <20220813161220.6039-1-tangmin@cdjrlc.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 10 May 2023 10:45:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_+kCTU6Hng0b8_9hdq+4Ge9s6DbXcw7hTCy-JOU7ArPg@mail.gmail.com>
Message-ID: <CAKYAXd_+kCTU6Hng0b8_9hdq+4Ge9s6DbXcw7hTCy-JOU7ArPg@mail.gmail.com>
Subject: Re: [PATCH] NTFS: Unneeded semicolon
To:     min tang <tangmin@cdjrlc.com>
Cc:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-08-14 1:12 GMT+09:00, min tang <tangmin@cdjrlc.com>:
> There is no semicolon after '}' in line 902.
>
> Signed-off-by: min tang <tangmin@cdjrlc.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
