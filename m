Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD12774171B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjF1RXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjF1RXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:23:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF741FCC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:23:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so5323364e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687973012; x=1690565012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqIqFUPFrsKoIzLWBGgp2HjNxkpNScvy103dAekNK5w=;
        b=iO+yzmLlBkR+O04yTgo80XMCjE1b80WI/5T4Qt+zTpN+zGPz5uUifYYcilgLFgMHlu
         KRxvTMs2ZdJ5lItvmKidStNdeww57cz5o093LHLryAOWX0mjEFxB/a5kzgIFkFBD3YlU
         +D1ZnbfS+sh+CSyY39sAcSRMdmntP6SsFXeNJU0rDO5cbX1P57xW5ZRi6WlYNSHkr0IQ
         arbyQtQnxWUZGkqsK0ZlsXC6Hpc6EC3nZ9MEER7r4rJ01FEkQzjNOSJ5nrkBS6KXOD+Y
         aq5OoGfAThvZRw/LqxpPX05JVvc7EhBP60vZwNHAEiCJXpHKfesydgdF0TUxzYFw98/8
         cNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973012; x=1690565012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqIqFUPFrsKoIzLWBGgp2HjNxkpNScvy103dAekNK5w=;
        b=ZS5bkETfPE7FTB7b9W+65NE0z9Rp2558b5tR51JE+6W3/VQaCgQdEGAomfXcH+/0NC
         ZMjnhELU++RpuI7wa40iDlAVGaoWXtjY4/ieO/HW8TNZu/7Uy72Pj+NCCeXtyQ4tE+y2
         oR9FUk2eJ377oN9aqPn3qq006Zz0/7j/y1q1ReT2O6yfwAQb0+fGpUFFWAuX1wsi2HQN
         KYL/VRfM/Deklh+auKWv6fh8CRXhqOOfNk/xhgyc/W3oNwWpphbKbekLSkfVj+lnroQz
         QfkfkufoYxOKjp1RcSM1e5ppmj5kCCynxdg6neicCjaQYLejxGkpcm9AvqZFrSZ+yfNV
         gVjw==
X-Gm-Message-State: AC+VfDz9llnwVHx302NyIihK2RZ7v661CVTmyyAS1lvpuqEWlPXDEqJl
        6hp8XWwad2azNVHxF8gZFy7Uq2JUt4/ZnFoXBZfVhw==
X-Google-Smtp-Source: ACHHUZ79N/TpxztcIneHGSQv13tw7uydK8uMAMcNq7uhd3nC2sjwlTTVD5XfZdbpiDrun3fawZh0gaSMQ8wx9lp5nbA=
X-Received: by 2002:a05:6512:e9d:b0:4f9:b6f8:844f with SMTP id
 bi29-20020a0565120e9d00b004f9b6f8844fmr8662285lfb.39.1687973011995; Wed, 28
 Jun 2023 10:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230628131442.3022772-1-sameo@rivosinc.com> <20230628131442.3022772-2-sameo@rivosinc.com>
In-Reply-To: <20230628131442.3022772-2-sameo@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 28 Jun 2023 10:22:56 -0700
Message-ID: <CALs-HsuccHQiHEtJ+=s-YS0kHLhwOUnDUY7eP5W3BL2Lpx5+9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 6:15=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.com> w=
rote:
>
> From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
>
> Parse Zb/Zk related string from DT and output them to cpuinfo.
>
> It is worth noting that the Scalar Crypto extension defines "zk" as a
> shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> Zbkx, Zkn, Zkr and Zkt extensions.
>
> Also, since there currently is no mechanism to merge all enabled
> extensions, the generated cpuinfo output could be relatively large.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> will generate the following cpuinfo output:
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
>
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>

Reviewed-by: Evan Green <evan@rivosinc.com>
