Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D074384A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjF3J0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjF3J0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:26:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D62680;
        Fri, 30 Jun 2023 02:25:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1992656a12.1;
        Fri, 30 Jun 2023 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688117158; x=1690709158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ5a2srxoFiXek9tQGwsUQjYNhzdfJ4/8ulGPIP670A=;
        b=GOyZ/dMB/Pef4H+8d2viuxbPuaivfGZE1h3LH5ciaBA7lIbBYgmTwlOSaOAPpJmY21
         zFqVn/AI/v05Cuy5cKu47aNJlK+2/t9mJ/HisYy4Lf8XJ+fWgY9v6XO8qZa4+YQ0mse5
         vuj5i1byARMQT59AAaurl0nWFJuPwtrANrZlRsBhnv4gPIuw0FdEQukYw7WOsFfcl9CY
         ErWUzU6t739/rbvzGOTkrpBGqDMksiPk6egMJogplE9dRz/GBml4OSdX+lo9oesL2hGU
         Maw3WLNtVqz5vj4Clhx9RH+D2Bh5+hrvyY+/v6R+Wt0+Tz5KYRafJpwO6wb+7xscv+fx
         4YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688117158; x=1690709158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ5a2srxoFiXek9tQGwsUQjYNhzdfJ4/8ulGPIP670A=;
        b=CWQCiIF+NOs0+5PINUPMLccKZzaD1k1DLopiIt3WJasT0D/9sw69/tEMg4C1H67ccJ
         XkmzM5bYdtQAyRjPiqeCe/xxw1/UTPINC0RdCW1xlm/pgk1cXNXVUppE05Lybc1kOnUU
         9Ef5db344XoV9bIT10fi673Gl0EJ1YDTmIsoMxWCckffy8d+wefMwBuigjB5XZJIQlpI
         h/5n177sp/HGcJ0x59xOpMkcc7s8p9/XyVROhyud4ZdtecVfyuQgOEQ/Uu50Pe4sxptQ
         R4XKLeuQJ4vDx8wG3fjtMK4MizaqPpv4iuhxmtW0X0o4pArgZOFM33KleynuRTFbin1m
         JrTA==
X-Gm-Message-State: ABy/qLYhoXdPo2925odicaO9wNcCl/niGMkxTNdRbU839cHRA4hFou05
        JqFY60JHPz0ekxT2faeD38bKBpBLAUkMcVP/N4w=
X-Google-Smtp-Source: APBJJlHZDcnzgrM/KBAzpI5U/RnXGz1hcEUwDSkYxFa1zNyV+9yHmM+XzpADCCHE8/o4Elsqw9waYh7UG2tuvB7WO1Y=
X-Received: by 2002:a05:6402:3456:b0:51a:50f2:4e7a with SMTP id
 l22-20020a056402345600b0051a50f24e7amr1224188edc.13.1688117158223; Fri, 30
 Jun 2023 02:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-12-git-send-email-quic_mojha@quicinc.com> <99c98f22-69f7-4a6a-acc9-6a6a6bdb2031@quicinc.com>
In-Reply-To: <99c98f22-69f7-4a6a-acc9-6a6a6bdb2031@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Jun 2023 12:25:22 +0300
Message-ID: <CAHp75Vd9+YHbExOQwK6bVHD016kB599yxUrj1PYFb__zENDi8g@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] soc: qcom: Register pstore frontend region with minidump
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
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

On Fri, Jun 30, 2023 at 7:55=E2=80=AFAM Pavan Kondeti <quic_pkondeti@quicin=
c.com> wrote:
> On Wed, Jun 28, 2023 at 06:04:38PM +0530, Mukesh Ojha wrote:

...

> > +             scnprintf(name, sizeof(name), "KDMSG%d", i);

Also a side note: here you use the 'c' variant of sprintf(),why bother
with it if you don't even check the returned value?

--=20
With Best Regards,
Andy Shevchenko
