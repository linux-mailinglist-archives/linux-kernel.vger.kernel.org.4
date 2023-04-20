Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619246E8AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjDTHJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjDTHJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:09:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB044C3A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:09:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id j15so1518190ybl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974543; x=1684566543;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y0/WJr9NXyXj0sm8yF6f3Z7V7ChyhbGL1tQ/przy9yE=;
        b=bw+uW+kq/RyY7nevlBBAFDLCnSZ7wsiv59WeY0YX8aN+B6bTxcAI41C0WQIKmCe9jK
         Af31yWI0oavuDXeTU0BTdx58Q9YKPLCzKiTFU2nNLaggNhVfNZ6+toQwAQ6wHh8c70+H
         tZKkcQT3wB9mbgmAIV2hDiEUF6RUgXOwlKYSegGIcOVdYGEKmGPUrL6ujwz1g7re4WUb
         H/pioxnoxvOzCZfEt86lc1Cj95CTcpLyHahNwNJYvQyJPSE15vp3JUBQLzQ5iEW6/WxE
         UsytDtymBaZe2W8gwXZpNEf9FL2z8sg8owNR0POOR5GNKaXgFvY3ES//QHMoaTbE6nrZ
         A/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974543; x=1684566543;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0/WJr9NXyXj0sm8yF6f3Z7V7ChyhbGL1tQ/przy9yE=;
        b=lDGcvQJ5ut3oXj6Vfy5hh1O4pD/GKLX2athPFeM+BirOPzjdVBuF+cf9RVkpd+lE3y
         MRqEE/znOKoTGq+pkUq4wwxATR8vZ9Kz+70liUPIFmT9SBP/pXlrwqCtsfFj9wQkpI+Z
         98aADLoi3D1FJLHnD0J9FDF2DGfuQVy92GxLynPRy3wfee8q12ZHZ7R/sJq7uHYaQZ+5
         G8iyIN6bSThaORMtDH8ElMXbCce2tpuls0guadkgA7+qCJPnI88bMN+WqkdoY4OxZROR
         0/hAFN2FhUfLQXg9Lst7wC4+Eau9DePhlDtrkCVCHlfrjJar4adkMcrsmxxW8NUAwUrD
         E5ww==
X-Gm-Message-State: AAQBX9cOTpY0QkaanJt1sW7QfjTTpQfw0v8+/yJbBrX71LJ6mmpBGcTQ
        lMou3b+z+tv6vdRthkBmgd82xENGimlCAYjDMrc=
X-Google-Smtp-Source: AKy350b/JC6pfHLNmjom4+xY97M3JSWhaAUooXpfCdAyitDPpbp7eFsFKNxsseq3ZY+kuxNuEfnMkbZo6dWXSqY08DA=
X-Received: by 2002:a05:6902:1242:b0:b8f:4137:728f with SMTP id
 t2-20020a056902124200b00b8f4137728fmr479216ybu.42.1681974542476; Thu, 20 Apr
 2023 00:09:02 -0700 (PDT)
MIME-Version: 1.0
Sender: jamesnjagi610@gmail.com
Received: by 2002:a05:7108:632a:b0:2d0:2caa:7937 with HTTP; Thu, 20 Apr 2023
 00:09:01 -0700 (PDT)
From:   TOM HUDDLESTON <tomhuddleston188@gmail.com>
Date:   Thu, 20 Apr 2023 10:09:01 +0300
X-Google-Sender-Auth: qU4UY-sLoZIM6yQfvRbnoq5OJBI
Message-ID: <CANQ-U-xU8nhy0eSX5a2S6HzmC_KY7C7Gb=UXXwthoa89Wp=vLQ@mail.gmail.com>
Subject: =?UTF-8?B?0JjRgdC60LDQvdC1INC30LAg0LjQvdGE0L7RgNC80LDRhtC40Y8gLSDQsdC10LfQstGK?=
        =?UTF-8?B?0LfQvNC10LfQtNC90LAg0L/QvtC80L7RiSDQvtGCIDgwMCAwMDAg0LXQstGA0L4=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0LXQudGC0LUsDQoNCtCd0LDQtNGP0LLQsNC8INGB0LUg0YLQvtC30Lgg
0LjQvNC10LnQuyDQtNCwINCy0Lgg0L3QsNC80LXRgNC4INC00L7QsdGA0LUuINCf0LjRiNCwINCy
0LgsINC30LAg0LTQsCDRgdC70LXQtNGPDQrRgNCw0LfRgNC10YjQtdC90LjQtdGC0L4g0LfQsCDQ
s9GA0LDQvdGC0LAg0L7RgiDigqw4MDAsMDAwLjAwLCDQutC+0LXRgtC+INCy0Lgg0LHQtdGI0LUg
0L7QtNC+0LHRgNC10L3Qvi4g0JLQtdGH0LUNCtGB0YrQvCDRgdC1INGB0LLRitGA0LfQstCw0Lsg
0YEg0LLQsNGBINC/0L4g0LjQvNC10LnQuywg0L3QviDQstGB0LUg0L7RidC1INC90LUg0L/QvtC7
0YPRh9C40YUg0L7RgtCz0L7QstC+0YAuDQoNCtCX0LAg0LTQsCDQs9Cw0YDQsNC90YLQuNGA0LDQ
vNC1INCz0LvQsNC00LrQviDQuCDRgdCy0L7QtdCy0YDQtdC80LXQvdC90L4g0L/RgNC10YXQstGK
0YDQu9GP0L3QtSDQvdCwINGB0YDQtdC00YHRgtCy0LDRgtCwLA0K0LvRjtCx0LXQt9C90L4g0LLQ
uCDQvNC+0LvRjyDQtNCwINC80Lgg0L/RgNC10LTQvtGB0YLQsNCy0LjRgtC1INCy0LDRiNC10YLQ
viDQv9GK0LvQvdC+INC40LzQtSwg0LDQtNGA0LXRgSwg0L3QvtC80LXRgCDQvdCwDQpXaGF0c0Fw
cCDQuCDQsdCw0L3QutC+0LLQuCDQtNCw0L3QvdC4INC30LAg0L/RgNC10LLQvtC00LAuDQoNCtCc
0L7Qu9GPLCDQsdGK0LTQtdGC0LUg0YPQstC10YDQtdC90LgsINGH0LUg0YLQvtCy0LAg0L/RgNC1
0LTQu9C+0LbQtdC90LjQtSDQtSDQu9C10LPQuNGC0LjQvNC90L4g0Lgg0L3Rj9C80LAg0L3Rg9C2
0LTQsCDQtNCwDQrRgdC1INC/0YDQuNGC0LXRgdC90Y/QstCw0YLQtSDQt9CwINC40LfQvNCw0LzQ
vdC4INC00LXQudC90L7RgdGC0LguINCS0YrQv9GA0LXQutC4INGC0L7QstCwLCDQvNC+0LvRjyDQ
stC4INC00LAg0LzQuA0K0L7RgtCz0L7QstC+0YDQuNGC0LUg0L3QsCDRgtC+0LfQuCDQuNC80LXQ
udC7INCy0YrQt9C80L7QttC90L4g0L3QsNC5LdGB0LrQvtGA0L4sINC30LAg0LTQsCDQuNC30LHQ
tdCz0L3QtdC8INCy0YHRj9C60LDQutCy0LgNCtC30LDQsdCw0LLRj9C90LjRjy4NCg0K0JHQu9Cw
0LPQvtC00LDRgNGPINCy0Lgg0LfQsCDQstC90LjQvNCw0L3QuNC10YLQviwg0LrQvtC10YLQviDQ
vtGC0LTQtdC70Y/RgtC1INC90LAg0YLQvtC30Lgg0LLRitC/0YDQvtGBLCDQuCDQvtGH0LDQutCy
0LDQvA0K0LTQsCDRh9GD0Y8g0YHQutC+0YDQviDQvtGCINCy0LDRgS4NCg0K0J3QsNC5LdC00L7Q
sdGA0Lgg0L/QvtC20LXQu9Cw0L3QuNGPLA0K0KLQvtC8INCl0YrQtNGK0LvRgdGC0YrQvSDQvNC7
0LDQtNGI0LgNCg==
