Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF52626C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiKLW74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:59:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15589DE89;
        Sat, 12 Nov 2022 14:59:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so20276742eje.1;
        Sat, 12 Nov 2022 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwUb/APyWuW1/kclxSS68ZW9lC0Hlt/bCdjo4FRubHc=;
        b=bvLJAI/b1EMO5ZIviIHZQnMVUmbZ+2sW/NG8o7YlSOehG/WFae6ye6fILVMLqw9IgU
         2+iLDiS70uWVF0RIEyONdL9a2RZ3DQK7lQO/j0ZowCKIt4i1JlsWDt9w9ZKxKpejg6ml
         Ne5uayImLJ6TqOTTUUVofoOdC9Jg6R1FHBqKpifCPc7/7dMu7bsgmmpyKSEEnmlubGCl
         yvEguVMk55xru0YBpXKG4sE6g1OTMwRnWvFdrSteX7IUcE4IqFaXJd78L5Jok0qUCa9+
         respKjRT4RjHqc1+mS2ay69bWRhuJXd39XTAaKJtvQkCXcsWscm7FTWZUoq/xXK0I4su
         MZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwUb/APyWuW1/kclxSS68ZW9lC0Hlt/bCdjo4FRubHc=;
        b=u0Y57u2fedov6rKpmHOK3gGuBww55CT3028Nra3gIaEYWoVMbaVrmEWXpEu/Hn//Fd
         SHO+GZ+T6uaEYdXjWFfTkFfraLCncExCFQJB+VX0z5MJgUw200HMGaciSilk1ZHbWPpz
         N50uplcYw7qwOYZSWptREOrdrd0VvG+rtnosD68/dTJOh0AbicHGMEOF38agopfwyTyx
         2rw3WekLp3x6Kx1Q6XWcBiXVxt2QYoiiBd/9oAl0AOPCufaeThIm2DQIROaE/1+V70SR
         Rhrm2Rpo/w0JTGAjxeKjrD7SqzwUVGsCMF5k44BL5lCFrP083Av7Qm7WgJ+GKE+dtZpG
         OdKA==
X-Gm-Message-State: ANoB5pmYMyAG82m2L1lvHBDJhgfpCqA2Waem2LUoqsA7vzohxh1PoTMl
        LppJ+y2Poos4BQ5myFZ7l0GgdPxiKc2NrBw1viY=
X-Google-Smtp-Source: AA0mqf5hbdSoTmGDxzeKtYkuV8yK7LEKAQby4WPcWMwPXl2OjSCB76ngcb+yRGLGT9dr2qqCyLRrpIF2EJurN0P6y9c=
X-Received: by 2002:a17:906:2ecf:b0:778:f9b6:6fc with SMTP id
 s15-20020a1709062ecf00b00778f9b606fcmr6409555eji.580.1668293989543; Sat, 12
 Nov 2022 14:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20221110150035.2824580-1-adeep@lexina.in> <20221110150035.2824580-3-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-3-adeep@lexina.in>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 12 Nov 2022 23:59:38 +0100
Message-ID: <CAFBinCA1a_ZaG0Pb7z=oBgrvfYJ4oJ_uJ3SY-ddjAmzCSbGmVw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: amlogic: mmc: meson-gx: Add dts binding
 include for core, tx, rx eMMC/SD/SDIO phase clock settings from devicetree data
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Vyacheslav,

On Thu, Nov 10, 2022 at 4:02 PM Vyacheslav Bocharov <adeep@lexina.in> wrote:
[...]
> +/*
> + * Cfg_rx_phase: RX clock phase
> + * bits: 9:8 R/W
Generally register values should not be part of the dt-bindings.
If we need to make the phases configurable through device-tree then I
suggest using the human readable values (0, 90, 180, 270) instead of
these register bits.

That said, if for whatever reason we need to have #defines for this
then they should be added with the dt-bindings patch (and also carry
the dt-bindings subject prefix) instead of a separate patch.


Best regards,
Martin
