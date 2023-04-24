Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE76ECFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjDXOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDXOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:08:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FAC6EA8;
        Mon, 24 Apr 2023 07:08:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so6547994a12.0;
        Mon, 24 Apr 2023 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682345283; x=1684937283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dTQC2SeEl8be3Abj1jqdXgl7qG00ewVdD6w4MrH7rg=;
        b=PHkDavr5I3cZrizQoGqNLI2rACfiYvyfeCsFY7WjYUj1ZLhJQHWun3L/DHpo+GX7N8
         HLMMmDNQtvaduFV/W6QUQG+kC0N4lxIxbIepGRRDYnf8uA9xjSymt2pkZBIsS+KEWHzF
         fUs2UlmtkFwzBPPHe4m+jFO39SCtCF6h+2DPNtmeb7Zv576nGSI7pmxK0ZPdhptWlcKH
         KsqSNiSeBp/J9dQWQ3g7ME/Q2bNSDvF+8jqZSBL5/5Ryiipf7BB4JzTW/mZTLhGthh01
         3pnH69ZcPk55rJg1jnWycL18R2b899KtdkuLq7V7uNqiOvrOUwXJsK+kO5xd+aW2maX3
         wv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345283; x=1684937283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dTQC2SeEl8be3Abj1jqdXgl7qG00ewVdD6w4MrH7rg=;
        b=Mmjgk9WtMKyOe7bbPZjXPZH0IoQrqwxXBscOL0VHhmtgwCGuVxR6Vfhbnph9hq4ofq
         6Nqo4bV44NzqRnYux93UlkOmKvIdqlNVVJWKC9oQWiZrgx3i8t/4q0/kCRLAnpQKrW2J
         d3itvCEF8JsaiqQOqGSaDuCXofgHQXTeLmgzbuXGcow2C2qnobp5ONgusR0L1wWwtSb5
         JtqdtJ00mAA7/xi3Zt/gNyqOZDGzWjWQhVzQHFkOepN70jHsXTJEAK3vWGExFxLqjuTc
         LXzYRm010dzdKN1iPs/SjOte6+fHaOqrqIQgII0Y5fVULBXRTwSXHEEk6LW0zuMe5RIO
         7jyg==
X-Gm-Message-State: AAQBX9fS4VnToVz90Avco41zMQ4kR0KAKVglU3f0xa17tyL7gK5DA79J
        VsntnPwC3XmtSdYtytGN17O3Uy7RDkURAgV3HztTZZBR
X-Google-Smtp-Source: AKy350aCLcgNjsQS/brCG2IqJ5QLVTL4vgC30/G0P9thgpJGzY3+8zpANxxUXZq0aFHbmZD4Fnk7iW4PpmTmLKgXBrs=
X-Received: by 2002:aa7:c9d1:0:b0:506:85b4:b14b with SMTP id
 i17-20020aa7c9d1000000b0050685b4b14bmr12212242edt.29.1682345282560; Mon, 24
 Apr 2023 07:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
In-Reply-To: <20230419175538.855493-1-pankaj.gupta@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 24 Apr 2023 17:07:50 +0300
Message-ID: <CAEnQRZD4-BofvpLaatbYnw3G7Mrs35ZiZsrRJmjrZA7qY_QbHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] *** firmware: imx: NXP Edgelock Enclave MUAP
 Driver ***
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
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

On Wed, Apr 19, 2023 at 3:45=E2=80=AFPM Pankaj Gupta <pankaj.gupta@nxp.com>=
 wrote:
>
> v2 Changes:
>
> - Fixed Kernel Test Bot issues.
> - Removed ".../devicetree/bindings/mailbox/fsl,muap.txt"
>
> v1:
>
> The Messaging Unit module enables two processing elements within the SoC =
to
> communicate and coordinate by passing messages (e.g., data, status and co=
ntrol)
> through its interfaces.
>
> The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically tar=
geted
> for use between application core and Edgelocke Enclave. It allows to send
> messages to the EL Enclave using a shared mailbox.
>
> Patch-set add the ELE-MU  kernel driver for exchanging messages with i.MX=
 NXP
> ELE IP; both from:
> - User-Space Applications via character driver.
> - Kernel-space, used by kernel management layers like DM-Crypt.


What's wrong with existing NXP MU driver?
