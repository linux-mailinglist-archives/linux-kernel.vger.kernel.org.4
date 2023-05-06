Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980CB6F8D53
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjEFBBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjEFBBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0814EDC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B302641C5
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B1DC433EF
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683334867;
        bh=Q3itPhUCs9C8rwLmk0xSA05Z3HnEQP/E/Xa+mK368uQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qohq5184waisTvURiKc/qTLZtuE10ShoVo0X5ASfso52UABo3CEt3xc9oZQit4Ct0
         dlcyW5MJgFEToEIUYIeHDD4H8ywU4yExgDSTNKGIyKYx5iZU527edWoh70EcQGBoDf
         KRoeX99HbB5qveNhwwNip0cWPuwln87tapnVamJmFNK6cwsohYw5jq/n4KB9esQcTQ
         BcX8ZBOkp8td9jN02aGkg2Etep0er9sDCHh+6KKzYq9R53NmnwV++6e9htY3g1J9Rn
         73iMMeWGkHsSEIFmwWIIkHZS9DkYHKZ3Bx/W2lUenLbOMKIyNWC+1O8yL55Kp5fa2M
         hrFN5Wy1yROvQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1928860f63eso1605347fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:01:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDzZXdecv7yEZDCFfTnX2eKFgLIh/hCV0iFdlcDCCN957W7ftzNg
        e4qsy5yVO5tR4xTCk9azyVnd2rK+HD13mplhjQE=
X-Google-Smtp-Source: ACHHUZ4R3+T3mFgQcs1GyVO9GuU4qBBlPzOU6JLDANY67SB91DgOqdAGEej8ejI+9fvVhTUMYfHYw3CRPXix7+PfSmI=
X-Received: by 2002:a05:6808:b11:b0:38e:e022:7a02 with SMTP id
 s17-20020a0568080b1100b0038ee0227a02mr1300383oij.10.1683334866989; Fri, 05
 May 2023 18:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:981:0:b0:4d3:d9bf:b562 with HTTP; Fri, 5 May 2023
 18:01:06 -0700 (PDT)
In-Reply-To: <20230206091815.1687-1-wangdeming@inspur.com>
References: <20230206091815.1687-1-wangdeming@inspur.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 6 May 2023 10:01:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_LnFMEEXWncTA=Y9xbHwh+GmZETM6WBQQ2hqPO6fZuZg@mail.gmail.com>
Message-ID: <CAKYAXd_LnFMEEXWncTA=Y9xbHwh+GmZETM6WBQQ2hqPO6fZuZg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Correct spelling
To:     Deming Wang <wangdeming@inspur.com>
Cc:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
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

2023-02-06 18:18 GMT+09:00, Deming Wang <wangdeming@inspur.com>:
> We should use this replace thie.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
