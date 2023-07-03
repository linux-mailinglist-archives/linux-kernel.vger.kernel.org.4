Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF731745D52
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGCNat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCNar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:30:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A160E50
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:30:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3143b70d6easo459728f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688391022; x=1690983022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZnnVKMWmgBZv3yMj96JcjDuZoVh3HEOvpCHPpz/5Hw=;
        b=RhWjkWg47DeZvNYSTBWmzfRWp/NSRN7KvZP+k+WDia+g2UwEY3uMkFbc0PV4+VjKxI
         ihlj1ack+jSKLBZDbdWN2Rn8TG9dLXZKmOi7ZWLwSFfTG0si6eteY/Q2W1reSpUmiG4Y
         Be3f4CybS9YtYRzva4QvLgWuhRgQIifKVjD1MStbRBDUzKFx+/1KkHSvNjAkUJdYOjOE
         843n9xW8eodngvmbdgGDyxUO63z8v2yQmYuRcO2CDPTM2aVXyOlxXnlrs7ypp363cSdB
         txQZYnhUHB7E5T2sN+H3RLfcVqE25ongv8xBfXwTPA15FyxbfZ7FF7aAMaIjd+W8hr8M
         zl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391022; x=1690983022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZnnVKMWmgBZv3yMj96JcjDuZoVh3HEOvpCHPpz/5Hw=;
        b=NnI9hhy5/Uk73sR/Hffn2Z4cMs+LwS749Pam/FA8fh4+asSKq6C8aIKNJyEpfDH9q/
         XvuoLCxYHnOHjxRu9ZNmfXMSBgWICYEt19mx8bXB+cDRbyTEbiJ/BEKQ8Qb7pd2XwMTb
         9SrZOozueiPd/IGu8OpHKk5i5VMLork5gGanKS5tczkYW8UQTy1H0LT53V7hBFVVyiYj
         IS3tsVG+7Ctr3H88/h8Tvzrs00aZJFbBkI2VM7+L/VtZkCTKZGUggVvc0nqsOyVFECg3
         DmOP6zt1zfYHRiwJcRIv/VOxus4N+bjuQ0T/C9nFPBVPUetKAvK4ZF/fYSCs9nr+EdQP
         ycKg==
X-Gm-Message-State: ABy/qLalvWO8RxDqOKxsViwqZ+SB6W4zL0MIV01wr7Im2zgfj3VqI5Oh
        qQakobc4HcpV7iF6CDYMTocJuRoYBsXaOv3ercYYWg==
X-Google-Smtp-Source: APBJJlFLHnoWLC7fXKGELY0yfhUnCQIhkvaJIxen0SRkggMiciJCwTGHTehB9bng5XROJZG+5KrStqYwIAfQ6Z10yaU=
X-Received: by 2002:a5d:5410:0:b0:314:17b0:d35c with SMTP id
 g16-20020a5d5410000000b0031417b0d35cmr7098244wrv.55.1688391021887; Mon, 03
 Jul 2023 06:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230703-71f67eb66a037f5c0fb825c6@orel>
In-Reply-To: <20230703-71f67eb66a037f5c0fb825c6@orel>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 21:30:10 +0800
Message-ID: <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi drew,

On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
>
> (This is a reply to a non-existent cover letter.)

This has been discussed many times with Ard, Please refer to :
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cui=
yunhui@bytedance.com/


> I'm not a big fan of adding yet another interface. Have you considered
> doing something like [1]?
>
> [1] https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPkg
>
> Thanks,
> drew

Thanks,
Yunhui
