Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D987430EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjF2XL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjF2XLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:11:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00A199D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:11:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso2021300e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688080309; x=1690672309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwBX7q5dtknbGomGQRJHsffI3iPVn9g8XuVPo/NHc5I=;
        b=i4Jf468PDU/jpM64AFMYSZdOsJPeMOgikZjuhk9I1HT59sEShjOQa3Cz3cELcrochh
         C6KLqPsnHQUo0VMkG4S2l1qKYbKUpl1cuPjYtI9qV6upDUY3TnG+bJAZYXDtFVZ1K6u5
         o/R3yS+EqKggve5fi9XrePJiSQzvbA65XJHbZ0jkYMStC6fc9mVmrV2rFPAoLwor9byO
         IpQCNb+jcoE8DfsaliMzCrNH22W0NWw0HdcLUEP86+e5eWrW7ULbhH0JXZyM+/8+3f7U
         kEYNpW+b3y9KSqlNYGzk4JNfR3ExYDIOtNle0Nt8kwL7eHgNLUjE3yN0in2mTEAezSzE
         24Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688080309; x=1690672309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwBX7q5dtknbGomGQRJHsffI3iPVn9g8XuVPo/NHc5I=;
        b=g5d1tUMsTm5yTdY7vHI2f8dpyaA+gMzJ0hIixOHpZ8V/3n1ITbtZP/vM6wSRVshlED
         a40iPU8tQcKlU327xq32+9k3CUi3ZF/y9y6Nlefx9t01cFtgwFC79o5xYyBj3uwJHXDq
         MIV58MYDN5hUYXScvKtqtX91j/46sqULh9BjtJBNUYvYwcx979zdSM7nlZ2YrIh3gufT
         eNxfHOLPwRTxh4nkYqfefG5+QOm1JHp+JLIKXwkwPTvGdNRmYAIycGUJX/TSQ2kwT0S9
         utsoOHe7ecaaM3Bm5xvv+FSHXdF8B5HfIJumSpd9ncvH9zFoR9TO+CW6f0FVzW2vQLjv
         t+JQ==
X-Gm-Message-State: ABy/qLbs/nFsrwrE+iHsftRhgXkX7n9OwZnM+PHWsVD6elmbzRmyXWbp
        +rx6kJ8lPjBJCXFYz0OQoDZcdiMLGc9WunMz5Fkdug==
X-Google-Smtp-Source: APBJJlEormRhYZj0EFdg0C2hSimV6mwbCVwMKhCmJtPD2zLVec2g2bUJ3Bf7W/ZELa2aDVv6DlEX77bSge/z43MCKh8=
X-Received: by 2002:a05:6512:695:b0:4f8:68a3:38e2 with SMTP id
 t21-20020a056512069500b004f868a338e2mr1072204lfe.0.1688080309589; Thu, 29 Jun
 2023 16:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy> <20230629-uprising-harbor-439b85492132@wendy>
In-Reply-To: <20230629-uprising-harbor-439b85492132@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 29 Jun 2023 16:11:13 -0700
Message-ID: <CALs-Hstveza+RF0EP2XArXv1Xy5jQWv1VxjsgFbFZDn_9M03fA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] RISC-V: add single letter extensions to riscv_isa_ext
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 1:30=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> So that riscv_fill_hwcap() can use riscv_isa_ext to probe for single
> letter extensions, add them to it.
> As a result, what gets spat out in /proc/cpuinfo will become borked, as
> single letter extensions will be printed as part of the base extensions
> and while printing from riscv_isa_arr. Take the opportunity to unify the
> printing of the isa string, using the new member of riscv_isa_ext_data
> in the process.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
