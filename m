Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576926F64D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjEDGVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEDGVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:21:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE285198A;
        Wed,  3 May 2023 23:21:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so2675a12.3;
        Wed, 03 May 2023 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683181302; x=1685773302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdb7gDmzA/OxsJ8oOXOihmXXjZdQ7p+LmmhLEKFuDak=;
        b=Bx7iJpPeZaagU7I/xMfJMspxMOtxyFL+/s79rDidoxakV9/QqlEPidcnhSfpvA9tYg
         mRbG0ZWOMdpTCaQ/073232XQSalFQT1KT4mw1y/pmCj96SBSu9ZTQZ+0LpnAH/TDkVSM
         e+qen5HULM7NFLvUzvH+3sKtGtwjyAiMNiZVya4Ptpq0SlL5nZAIUWlHV/yeIUGtWw9U
         bQa6zEEMxnH99LVja7oo8bp50tUwnu17nmcqzhKNM+2OTmikoM3pEUAk4K/fCanVQm9R
         WfgG2mGiBKO02mykM5kY4IwS0uHcY9xS4lUWHSnjtO37asYv+K8PSMdHURvSxN33u6Hu
         pv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181302; x=1685773302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdb7gDmzA/OxsJ8oOXOihmXXjZdQ7p+LmmhLEKFuDak=;
        b=eXcPfhXTLF2J+Pt4lN5e8tseTxgi8SICVUJHeKpiVHuiZd6OFOCYzga+MPDAWeylCb
         hZkNlmspGFV7hwrcoO0kIZKDcj/Oaf0VebjIP8fGnRumy8DUVb9ZZ5L9h3VxYn01yVOm
         wdmLdFhfuEuECPfcyCrDxCf8uaAy8lsl/IlVbBM0KG17kjSmYxFAXJbkq9wQA9gLmU7l
         FGTp/CYJRjJZNwWbcwW6h1bngn1FgmBoU9lCui0THrGHArlpLLfTIrZlhPCoTpGXD6wQ
         cTTLUjG5PB5LQ42lyVEyTWhzNpZ2GCOA3h72h4oppwHhBOgTca97FsO6rM2i8ILC6xoK
         Ao/g==
X-Gm-Message-State: AC+VfDxNY1jaOOoJtkkhK5Q8JhLyn5Qplb4LS4qh6c6nWZgftVFLr4lF
        BfJa3l+abo35mbYquFllNgU2llDzZbEUV3cYbhI=
X-Google-Smtp-Source: ACHHUZ7r/yVa5bvFkK+1XXEjZWHNeSrTzRUpn8NAF1qy9eZ7rlXUXzdir1dN2fW5UOiL/fdjzP7FeBuhXze1cSB4wRA=
X-Received: by 2002:a17:907:7e8e:b0:94f:7edf:8fa1 with SMTP id
 qb14-20020a1709077e8e00b0094f7edf8fa1mr6230887ejc.32.1683181301725; Wed, 03
 May 2023 23:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230424231558.70911-1-quic_eberman@quicinc.com> <20230424231558.70911-7-quic_eberman@quicinc.com>
In-Reply-To: <20230424231558.70911-7-quic_eberman@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 4 May 2023 01:21:30 -0500
Message-ID: <CABb+yY3ojsGNm1w+QSn2BnbOMdcQZAV+=UYiMiBrs=jujP=pSg@mail.gmail.com>
Subject: Re: [PATCH v12 06/25] mailbox: Add Gunyah message queue mailbox
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 6:16=E2=80=AFPM Elliot Berman <quic_eberman@quicinc=
.com> wrote:
>
> Gunyah message queues are a unidirectional inter-VM pipe for messages up
> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/virt/gunyah/message-queue.rst |   8 +
>  drivers/mailbox/Makefile                    |   2 +
>  drivers/mailbox/gunyah-msgq.c               | 210 ++++++++++++++++++++
>  include/linux/gunyah.h                      |  57 ++++++
>
include/linux/gunyah.h  and
Documentation/virt/gunyah/message-queue.rst would need to exist for
this patch to apply.
If you made this patch as the first in series, then I could apply.

cheers.
