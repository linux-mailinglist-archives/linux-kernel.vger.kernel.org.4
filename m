Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2470F981
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEXO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjEXO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:59:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC6E58
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:59:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3078cc99232so946949f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684940335; x=1687532335;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPTeVaA5yO30H5vPCNeErOYkc0AROqP1l6DiC6Tyn6I=;
        b=vfpIgsnyUzdnKc4dwE+/96PjgIZvHt4dvbZ9oFQJRuK0CVK6zB1ExZEmqyOyDUEaMH
         BPpbUfdQjZ0taYzA1AsrlvN1tRHUAtaLiRwO/ppPt3tSnmEbi/0JPy5s7QiEBux76KU1
         +T0ASZwW7J5toOpu/nsp3pq2NfGxQd59XQfjtn70XB6B7U0d/h+ElY2TO2EwqmTVgQFV
         4Bnu2oFUhNfw46W86ylzigop/8xarM12LGwz50nrnW2lI8914SzNVvR466awvrLz/Th8
         2RTJ3NEnKOtlLRdaAzbNop6jsJMZCo+OvHfi+l+HAw/OtwY51swRPmgc8oYcxbSkPLMv
         Jkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940335; x=1687532335;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dPTeVaA5yO30H5vPCNeErOYkc0AROqP1l6DiC6Tyn6I=;
        b=SnOM1yr1u4xMjJj2MaxAAgHY6OnE95szncsMFy3FAbm1TsrhgYyrRD2kAFY/nTpNCt
         TaIdWCKv6zUVb/TnwSr6INM0J9eIOMUpeC7wjPanCTyYn4p5HY81VgMNNfRDOYjSMmKb
         pNpsNLm/mhsKVUfWXAYNOPf7yw70Vio5BvxBU7ojW9SoXXeKARikuiAMjjxNFI0z5ayY
         zv2aE0W1xAZCWRMN9KGd6Zy3c9rTAgIiasX2dTI1CUkB9ThiR71EVHffk2jJ7cyqLSlF
         OxS91Ar86yf2k6zULYYard6qxx88NV4g3n5qFtxSqoudWyBH2nDYsB53cI6beKbvvNxj
         kHOg==
X-Gm-Message-State: AC+VfDx3Bthesj/Mst7A9oP3l2EX8BQSwkvFpoCF0VJsBsro09x3k9jA
        7MXYVswgFNpZtrOyUehd3YhRbA==
X-Google-Smtp-Source: ACHHUZ6dUa6XUsPGDzubnTbiGkJc+yNunVFb4E6K7ba0Jf0QKNNJpz+ZBmF7UznoBG5dbpFM0aZNKQ==
X-Received: by 2002:a1c:7907:0:b0:3f4:2e13:ccdc with SMTP id l7-20020a1c7907000000b003f42e13ccdcmr126352wme.0.1684940335257;
        Wed, 24 May 2023 07:58:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b003f60514bdd7sm2724611wmi.4.2023.05.24.07.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:58:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 5C26E1FFBB;
        Wed, 24 May 2023 15:58:54 +0100 (BST)
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 00/25] Drivers for Gunyah hypervisor
Date:   Wed, 24 May 2023 15:57:42 +0100
In-reply-to: <20230424231558.70911-1-quic_eberman@quicinc.com>
Message-ID: <87fs7lwzbl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Elliot Berman <quic_eberman@quicinc.com> writes:

> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.
>
<snip>
>
> The series relies on two other patches posted separately:
>  - https://lore.kernel.org/all/20230213181832.3489174-1-quic_eberman@quic=
inc.com/
>  -
> https://lore.kernel.org/all/20230213232537.2040976-2-quic_eberman@quicinc=
.com/

I was able to apply the first patch but the second patch gives a 404:

  b4 am -S -t 20230213232537.2040976-2-quic_eberman@quicinc.com
  Grabbing thread from lore.kernel.org/all/20230213232537.2040976-2-quic_eb=
erman%40quicinc.com/t.mbox.gz
  That message-id is not known.

was there a transcription error?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
