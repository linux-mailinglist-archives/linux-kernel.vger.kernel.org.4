Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BFB715434
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE3Dfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3Dfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:35:32 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7BCD;
        Mon, 29 May 2023 20:35:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-19a347d69c8so3661924fac.1;
        Mon, 29 May 2023 20:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685417730; x=1688009730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4VjNC0LF+TbHs+mURTHmXgD0hOPze9ZN8bR7X5CNSk=;
        b=LGUPFo+iLAlIQdQAdRxrkby/iQpU3PiBO5bKBsRFnm+Y6Cv2OgvEFl42pdJ9RFFfTe
         XHkjymwq3cLB+gHQcHJoV3+b2OjEaXlMHZIQbmVfwsl19cuJy1sik4jJ19teAwytZjMM
         B+GB+0XNpMBTibSfc8a10oUp00Gxe54pnN1IigUyaJJSNx7bjsBXbnqOHHPA8zZRsgm4
         Gd9WGYa/BZW6Vyw+8gILlqi6bpE4Agcf1k4EuwdseAEjo1xT53PL2nWYAPsbpZTkRkY+
         N9VnQQ0mt9cmC577d5JQ3LWgYcwp54xAPfaux+UYGI5aOhlnD45348T1Vr2bfyY5nPWZ
         F1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685417730; x=1688009730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4VjNC0LF+TbHs+mURTHmXgD0hOPze9ZN8bR7X5CNSk=;
        b=HEvSSbWF33IJlw/BQWWcWeKMrHbrQiPEnL8PEoL14eIeJT2mvMnPrAUCyd9UbeZcEQ
         vLRu9EJaV/GTLgREiTvJh/gqoK+58mgjjo5yvHyyDJJ+/As+Cbi9xxRxxu/pP2cZax4h
         wY6BKyQW2Tg76ktvqJx5Xum9mB3ftxn6JvbLVdg5O5GmG4lWiAd2QSn/OWnJnFZmDQFF
         Dlj4H2X9/Yb9BRFsugJM91q8FeyJg1bcpmunuwcjZkvu3ojCRK6udijdCo28q3HkYoUt
         BDTisHJbMjOCe1hbu70yCogq3fPh3V1ILlS1aZYUjiBH2P+cW13lEfjLHESfSTOPaTTs
         k7sg==
X-Gm-Message-State: AC+VfDzNSZw1T/1dABFJKkObuc4pSsrgt90ZFCfZVpdO+WrZ2+OprURQ
        FkMY0c5kX6LilVLXZU2Pix53lcxErQ+3fLxYPAI=
X-Google-Smtp-Source: ACHHUZ6+zIkxN3C9WzXjAnT4zXK2VSRO8RckiYEQSnKbaPUYN2FatjU6gdYahNvRGTTQdPB4teG+rPc/enBFGyPJIHg=
X-Received: by 2002:a05:6870:9894:b0:18b:1936:30ee with SMTP id
 eg20-20020a056870989400b0018b193630eemr469820oab.56.1685417730035; Mon, 29
 May 2023 20:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk> <20230529150833.526084-3-liviu@dudau.co.uk>
In-Reply-To: <20230529150833.526084-3-liviu@dudau.co.uk>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 30 May 2023 05:35:19 +0200
Message-ID: <CAMhs-H-vwviikXFm7JnQffe3JxuBP-q2grJb15tUJ-OXGqONfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: mips: Add bindings for TP-Link HC220
 G5 v1 board
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Mon, May 29, 2023 at 5:08=E2=80=AFPM Liviu Dudau <liviu@dudau.co.uk> wro=
te:
>
> Add bindings for the compatible string used for the TP-Link's
> HC220 G5 V1 board, a wireless AP based on MT7621.
>
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> ---
>  Documentation/devicetree/bindings/mips/ralink.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
