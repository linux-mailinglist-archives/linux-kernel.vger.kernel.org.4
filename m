Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667C747CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGEGJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGEGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:09:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA210F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:09:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4035dd6b349so21425001cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537360; x=1691129360;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4skOAgaQEDBTny51kulEPxVs1bHErdGpJzYgrAxobs=;
        b=YnuiAKMaGdQOQXiZDH9kp+zT0/73Gh0XzXs6rj5Nr5oo+6iBf/Cy/+S7cgwwLJuGNP
         wdVUcYefj+vbk0vpADoilGMckUAtdGi/adsHQxYHSPfqqVJxCP6nCy2/SQTHlXiPnoiP
         1rKN0SIv7gGd/Eaa76miMRCadiITahpe6SD2wGvIZgrRBLej5z1suFhsqX1nQCdS+yCD
         1okWK2Rb7o+9DcJlh52aWEgLiRsSDXbcDrcDOcCVd9i7LbtpJ5fx6FF6XXY+jmWGaT96
         z+be88PF3ctPPklDGomIu0OAZrMOkFVjtimXZP0pgkP4CJMEYAIadV3JcLiovw87aw5q
         JJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537360; x=1691129360;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4skOAgaQEDBTny51kulEPxVs1bHErdGpJzYgrAxobs=;
        b=RPSqpgYBqA+oPljM3wJ8zsTpcEBl74LBXlyLHPdxCH+tRvSCj22E9awSbiH69SqChq
         1fXnDDwYD7akINmZvQzYsnERaWq3vK4gJfPFGd5G5Moh25MSAZTvGYE5Tj8Kl3N7Aer3
         8gL/NCwIjgTql7hEZ51BFZjI3vesa0UPGtM1PITjiSuZo2TXd9UKRxKWvFDnCPyVrkvm
         fGmkqgpUtM1gzf2Dx5GCQmNPsMJtUzcv2vBjEPJ/0F0/7/cB5bI033eSSWheWuIAuIky
         j5tN2XNlJtQOitWVsAagN5FMgyPaB5kU2NNSF7pDzzgO2EutKOIzbLuqXDcsOcNTT0fU
         qm6w==
X-Gm-Message-State: AC+VfDwQBUj89zAPq3cJyNB7UwN0I30I9UFek2vBnVdr228HRBwn3hPE
        WbA+wvd0CHYFrOrBhrMBx1CSKVR2zgg5uATRVJg=
X-Google-Smtp-Source: ACHHUZ6pbh9m4s4RGHzghHy78DD0/AKbi5w47E7W+NnvsYX8qHF7xzkFrXuNsQ4vsnuDcx6jP8IDjzNZkcRNasLgROE=
X-Received: by 2002:ac8:5946:0:b0:400:9b89:fe06 with SMTP id
 6-20020ac85946000000b004009b89fe06mr20087459qtz.54.1688537360085; Tue, 04 Jul
 2023 23:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7d48:0:b0:402:7480:8fa0 with HTTP; Tue, 4 Jul 2023
 23:09:19 -0700 (PDT)
Reply-To: leyjuancarlos7@gmail.com
From:   "Dr.Juancarlos Lemley" <cambeljohn41@gmail.com>
Date:   Tue, 4 Jul 2023 23:09:19 -0700
Message-ID: <CAA529ybNUtecA5QVs4g4gbA1-xgGS9ZRsYBse9tyJUkGAT97qQ@mail.gmail.com>
Subject: Urgent Attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have urgent Information for you.
For more details, Reply if your email is active With Regards.
Dr Juancarlos Lemley CEO.
