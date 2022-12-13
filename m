Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7768464AD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiLMBiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiLMBh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:37:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594C1D65E;
        Mon, 12 Dec 2022 17:37:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x28so2531963lfn.6;
        Mon, 12 Dec 2022 17:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H7oDX570DncmP/67wdnNqVdDmYUDKTn2XU4bJRVknIA=;
        b=gw0mgZ2erotEFYjA1YrjOMv1q8TMekLLITvdE6fwsIgGJ1zrKqfg9+wCgcbRCAy4hZ
         Rjr9uCeZ2CkwgwpO2XC3YsneFK12NfeY/wRUgcEf8gGF2xzqMvqEwieVnLej1xnIqGlu
         38FjOo6Q+uD08S9DWK8k6T8rjHcOrQkXd0ZeDiqGSToiwNOoJTfS75mr7sRDZ3J0yv1b
         TAsjYgbiN0QZ52pl1/xhxE5OJk+xenMZC2BjUGtiNg0ABOXScULBDztWj5LdTfBDIDhK
         n6owzQsb719q7AxTxK1DbZd5E4J5BBOqBloU/L63rKVYceSi3JizwhbvgRH5ZYVyQtka
         IuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7oDX570DncmP/67wdnNqVdDmYUDKTn2XU4bJRVknIA=;
        b=Z/ZIVlzUxNPITdyxWKUX4fyUQcKoPCGcMBv6NUIXioBKYsCBAjX0dtp6p4UWErtr2X
         jQZm7nbOiQhJRVF/F2oCSzNeIUbDEtfnA2esmZyluIMBHI2Lc1N/xI9GqM18m5ogJ1wT
         uqK4KCUF7J30ckkTXaSrgqcCeFAmNb5/cbgF9pj4E13T3nanPN/HOlajHvaY831y1mOu
         ucrHk0HXfvUuL83xooqoKl/VJ0cAnPLBI2/FNm4mvcHQzwtAWLjm9YoLFWst5fl2/xlu
         sYhPClApb7prJq9xWXoKsJ9QLjXf9k2qc9hF+Yb1dL/r8IAdPVahiUxatipmVZhv1Jjz
         I4GQ==
X-Gm-Message-State: ANoB5pn4PDiBoM/Xv2bysb4Wi+i1QACTXBYUDPRGH50wFbAwMcKVLYiy
        Fl6QcCI//lkdYj91xCHOnepJxrlEgFCIqVukjSKjcxfsw5EF
X-Google-Smtp-Source: AA0mqf7yGnvNdXtY4SXylNIvjTRn3bZjBpWoJYNeSC45AN+3BiIfKh9ErFXgu9emBkSNYUMwTtGtO4GCKaSJDTBfUio=
X-Received: by 2002:a19:ca06:0:b0:4b5:29fd:a58b with SMTP id
 a6-20020a19ca06000000b004b529fda58bmr16403957lfg.591.1670895443301; Mon, 12
 Dec 2022 17:37:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <b0efa2abeba389a7739ea26956e8b342c65deab1.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <b0efa2abeba389a7739ea26956e8b342c65deab1.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:37:11 +0800
Message-ID: <CAGaU9a9YW-5sumrXZbqFH9+K964sXekFvjyFafnT0_QVvSnuuA@mail.gmail.com>
Subject: Re: [PATCH v11 16/16] ufs: core: mcq: Enable Multi Circular Queue
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
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

On Fri, Dec 9, 2022 at 7:30 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Enable MCQ in the Host Controller.
>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
