Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5E682F75
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAaOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:40:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301C3D931
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:40:26 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 644FA44217
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675176024;
        bh=XHZduMLns3Y7r5k79prz1oAhShsJx/gipbVLJCHhlGk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=SH14Av2A8DeEBgkXLeBgXx4H4DrQ38qHTje8YPUR3jx/CV5CNXZK6DYcMCNyjgsAw
         Qo6SJDBI3CBz/XJ26BBtX8lP23xfNhvSbks9wZMtRoCdfpEdIclELPOSDGh5fXWgPE
         dLjEUx5dPZzXS51VMvZPTinEOOhD2orqTbS06i6PnE8Bzq9GTXNywi2o/MkXqiSEIh
         WEqZqIraKqwJLlkdxdrMuu06KTwzJnU9CFaZNr5teMHF8MdSDE0l4zk05rZOb5lfxA
         F0kMb6WPEUSPF8Td+wDRhU1OCL6JIzrfRZjTShGpjzwhZckuiYuuEhdVm3PntaCSSy
         RZWZBcC8VzOCA==
Received: by mail-wm1-f71.google.com with SMTP id h2-20020a1ccc02000000b003db1ded176dso5968546wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHZduMLns3Y7r5k79prz1oAhShsJx/gipbVLJCHhlGk=;
        b=sCk6gFzw8u79h1IfbevxgfmmAb0GVgpAsaOgMad0yZ9T9w7qM9gwbdd1RVrn3QmCfe
         oTG60xRCl6WJQM1fKRMmltDKgXeSvqBYsTNMQdDo4nki0WO7WlDtEW1lKfY9/G1Nuoko
         FutxELq1Z/uNImOtYL5B6UQCtVV8p/4S3v3Xd3QADXeUM0wutBsCnsMDfF/14wLJcPsI
         Lde2OYcpENT3a9LgqBXUqf3MMyObZzy6r0YQvchdJMyat+1FQmMQaz1n5KZRB6nWkrD/
         GdCKTolBnRPcU83jLGKDGTH2CTghxb2BEIhqEG43LOMqWy/ePT4cF5qfyrXeNr8o8nnM
         nklQ==
X-Gm-Message-State: AO0yUKUa7+LZDLTqCpFtXmr8qFiHCThDqx4wD3nP6aZUXcm9vzOryNJF
        jqL78UHx0zgKa4uIxpMqADks6hh+onRmgK8L/IMeWTes5OM3e8u4THKdU27DxvycwuBzgTilHW4
        at0KYiyY/pEfPz5ieHQocNXpMInNw4epNEQ4SY2Jwwg==
X-Received: by 2002:a05:600c:3b8f:b0:3dc:4633:9844 with SMTP id n15-20020a05600c3b8f00b003dc46339844mr15329506wms.17.1675176021642;
        Tue, 31 Jan 2023 06:40:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+EbSgEyXZd4rdDr0ISKIc/bI1f2vwrKcgwG0bUb2kTOVWw33DTexl9UMEDfIuhWw4JxLpblg==
X-Received: by 2002:a05:600c:3b8f:b0:3dc:4633:9844 with SMTP id n15-20020a05600c3b8f00b003dc46339844mr15329456wms.17.1675176021119;
        Tue, 31 Jan 2023 06:40:21 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id c3-20020a1c3503000000b003dc1d668866sm19414222wma.10.2023.01.31.06.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:40:20 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:40:18 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Willem de Bruijn <willemb@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests: net: udpgso_bench_rx/tx: Stop when
 wrong CLI args are provided
Message-ID: <Y9koUno9kGkNJkma@qwirkle>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
 <20230131130412.432549-2-andrei.gherzan@canonical.com>
 <CA+FuTSf1ffpep=wV=__J96Ju_nPkd96=c+ny4mC+SxrhRp0ofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSf1ffpep=wV=__J96Ju_nPkd96=c+ny4mC+SxrhRp0ofA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/31 08:35AM, Willem de Bruijn wrote:
> On Tue, Jan 31, 2023 at 8:08 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > Leaving unrecognized arguments buried in the output, can easily hide a
> > CLI/script typo. Avoid this by exiting when wrong arguments are provided to
> > the udpgso_bench test programs.
> >
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> 
> I'm on the fence on this. Test binaries are not necessarily robust
> against bad input. If you insist.

I'll keep it in the set (for next v), but I don't mind if it doesn't end
up applied. It was just something I stumbled into.

> When sending patches to net, please always add a Fixes tag.

I'll keep that in mind.

-- 
Andrei Gherzan
