Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA76A677F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCAGBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAGBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:01:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D94D37B76
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:01:04 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x6so7166263ljq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677650463;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huVRBaBa1UsBmB4k/zxht1N9AGT1Vl1CB7EEZBcTDjM=;
        b=lUEeIMiRlXE4R2gE7t7h1tL5FlF8C33YUSwEXVutt3qGvY+yiHyqbdH6REUQypZp6P
         C8IyAxsENYooARj2vbdWeBWHccrbKSVF/jA7SJvdL4vnTlHKcmCBH5zlrfitrYHXPhqj
         lBkII1SEZba70hNeLdze9BWO+pn5OyAhjYJB/EgZDeWs4wQCVikfghV8kr9nqzZwzlRb
         dGOyvuVSQo+Jw7JtJrX5++0ex9oj09Ol2rn0mJ5M/JbVmjaskJrx4fp2M04EtdxvwHZ1
         HOzgAw15Q+4LoninKU0jdrk3LjmpUCvRUL4chtteVvta36smtcd8p7KYV/bMU0VJl8ve
         ylww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677650463;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huVRBaBa1UsBmB4k/zxht1N9AGT1Vl1CB7EEZBcTDjM=;
        b=AspY1I0Xp0PpojZ0WlgcPaYRF7rR2xI7kSOsP1bLiTpNtYAkhlhW2P14TeUZcK763q
         tbNqZYGYA1EQFIlwiaB3IMHxvcYkvqVfIU6xG+mfkqI1xq5RO309WZmB0YrklsPxd53+
         rY95dxW3sDeaaX8H3Px8NPaJ1zungQEfADHQjY/KKErggmFR7W33s4wv8Z7vBtdGnOhh
         3AV+jVr+xblJSdt1N+n8RsWEDfYvpt3sCRb+qYGNTqvtqSSC3Dec2N7ws6TXv85mh2UO
         lBPHoBco3zJPVUGHvmLlKvjO3guJV8+K9PRI9KcEn4EdYyoBx5f5/W0pNZK8cesIxM3k
         +/yg==
X-Gm-Message-State: AO0yUKWmHjUSFtCd7mGNnUskvMtDIeybMCmOvoJHz7v77S4P3JxtIPjL
        YR185MYyqcSbhn6tIP0l5yzQRXfezNQFg38NVdg=
X-Google-Smtp-Source: AK7set9V0GZHBoI5GhnSXPq5SdBtkdhkNj7PveZuTMoI+H1CPkrzPzkYkH1mHU1uafYift7q3FRT2jE+Q/h5bNKjb8I=
X-Received: by 2002:a2e:b537:0:b0:295:bb34:9c2 with SMTP id
 z23-20020a2eb537000000b00295bb3409c2mr1601226ljm.10.1677650462707; Tue, 28
 Feb 2023 22:01:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:a98a:0:0:0:0:0 with HTTP; Tue, 28 Feb 2023 22:01:02
 -0800 (PST)
Reply-To: georgebrown0004@gmail.com
From:   george brown <gh727532@gmail.com>
Date:   Wed, 1 Mar 2023 07:01:02 +0100
Message-ID: <CAGrgnCyuQ_8u0WrqFpBnurVr=yoTfva5J8nZ0p8CAk9TA-E6Gw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150NCg0K16nXnteZINeSJ9eV16jXkicg15HXqNeQ15XXnyDXkNeg15kg16LXldeo15og
15PXmdefINeR157Xp9em15XXoteZLiDXkNeg15kg16jXldem15Qg15zXlNem15nXoiDXnNeaDQrX
lNen16jXldeRINec15zXp9eV15cg16nXnNeZLiDXkNeq15Qg16rXmdeo16kg15DXqiDXlNeh15vX
ldedINep15wgKDguNSDXnteZ15zXmdeV158g15PXldec16gpDQrXk9eV15zXqNeZ150g16nXlNec
16fXldeXINep15zXmSDXlNep15DXmdeoINeR15HXoNenINec16TXoNeZINee15XXqteVLg0KDQrX
lNec16fXldeXINep15zXmSDXlNeV15Ag15DXlteo15cg15HXnteT15nXoNeq15og16nXnteqINeR
16rXkNeV16DXqiDXk9eo15vXmdedINei150g15DXqdeq15UNCteV15HXnyDXmdeX15nXky4g15DX
oNeZINeQ15TXmdeUINeW15vXkNeZINei150gNTAlINee16HXmiDXlNen16jXnyDXldeQ15nXnNeV
IDUwJSDXmdeU15nXlQ0K15zXlNeZ15XXqiDXkdep15HXmdec15ouDQrXkNeg15Ag16bXldeoINen
16nXqCDXotedINeU15PXldeQItecINeU16TXqNeY15kg16nXnNeZINeb15DXnyDXnNek16jXmNeZ
150g16DXldeh16TXmdedOiBnZW9yZ2Vicm93bjAwMDRAZ21haWwuY29tDQoNCteo15Eg16rXldeT
15XXqiDXnteo15DXqSwNCtee16gg15In15XXqNeSJyDXkdeo15DXldefLA0K
