Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5604E64ACD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiLMBLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiLMBLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:11:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B51BE96;
        Mon, 12 Dec 2022 17:11:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so2417574lfa.12;
        Mon, 12 Dec 2022 17:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=esoVLCCBYM+KX0CUdhS5Tl7OrN1x4of3zTJl3qN9icA=;
        b=NMuhfgNsuogs/lKBdTzTSxywh7B2zonZdSfUoK/QPlQUZ/DQv7izsLVlBcVk0O5MZn
         Nn7FJSFaQ8TFy+/u/3L9TQqRaeEkVfJHNfmLV8ZmkNhWl852vmPc0u7i9BhDuilMbTEh
         RstFtmGbUu82ABJkPyur8h/J6d1RBKwLWDxYT+lJhlfw7bOR00ewNx6nqa799DiHjdEk
         MnfAUi6Z+F9h9bYT4i0aaBs8DMizbPNVzmGxo1ZuILxQgrhIqq+ssQpc4LXDeq2Nir07
         a1sq6TVT49UJXdHvXdb4lgJEkQQtz0VbY5Emrae7Uzwm52SEP9zOnfUEl/l95Ma0vuYN
         c1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esoVLCCBYM+KX0CUdhS5Tl7OrN1x4of3zTJl3qN9icA=;
        b=cg0R1/XHRltUYV6IuebKbzLgwBamN3G5sOzwZJmwc4FEbzckT4x6Tm6S4E4HlcCUMt
         qDPTbtU3MnaDO7QIB8+nrzTTJ8QG3qHYWB05qTxGlWUNBj9FR6Cnx5ZHOno8BOD7LV3E
         3Hnrqp7gOpuP219fC2NLN80hrj0Zwlr0YwnP+sUyHQVPlxRQm+uGwXimDkMQHr51XJB2
         QSE5D6cE++DszyBndXcYlzGmIGutGbYCKXe8nYCSriZ38UEqNXN9k/FGdzTGf1E22yET
         VPXaRZhjgKtPChTijQG0u6TGWg08faDgznj9crL9Gws1T7TsxcJsCTnlc77cJD0l12bm
         6oNQ==
X-Gm-Message-State: ANoB5pkOj1kWFzmdncdNKmokJSPH1DD06lkN1dv/lHAxDETsHKOaWavl
        qaitMyjmkOEvmPf+J8O6yOrFwALd3RQ2FV5yLteGLM6b9/5R
X-Google-Smtp-Source: AA0mqf58RZyS51eX38TmMel2o8skD5TQBzq3b+UAV6YS6xaih8iPW7Gjp7uYZtWR9RNFDqIDjwrAniqVO8EF3DtGd1k=
X-Received: by 2002:a05:6512:96b:b0:4b6:ea33:d0b6 with SMTP id
 v11-20020a056512096b00b004b6ea33d0b6mr331622lft.651.1670893858419; Mon, 12
 Dec 2022 17:10:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <d3bb47811bbdbb273f4a307ff514820d5be0f8fd.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <d3bb47811bbdbb273f4a307ff514820d5be0f8fd.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:10:46 +0800
Message-ID: <CAGaU9a-dCqgwNvqb+CXWuAtAxt06D2bUDD=FjoWs6m-fmiTUkA@mail.gmail.com>
Subject: Re: [PATCH v11 06/16] ufs: core: mcq: Configure resource regions
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Keoseong Park <keosung.park@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 7:24 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Define the mcq resources and add support to ioremap
> the resource regions.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
