Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E856DA66A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjDGADs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjDGADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:03:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F04C17;
        Thu,  6 Apr 2023 17:03:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l17so5105445ejp.8;
        Thu, 06 Apr 2023 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680825823; x=1683417823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+8kfy3tjKLPe3TifJTVuacG8Zo955zar201sEBpYQI=;
        b=MNxZauynb0gVNoahtsqVvCiD8C2zrTbmZyxhykOshWSl4e4x5UNTGqTuT7/wA3I7k8
         isZu/+ogsApfCs7W/ZB5fS6cxwdrbU9TU7BY1fI0qASwr6BjQJLXCeNFv+s+Xh83T/xY
         ll8AO3x+gov4OAc2i56yvml4nCb4zNkFKJ5u74M0JI4ko9UKgzW6TnWtMQRvEHud/aEw
         lomkn4kZSlpECT9vUFQuUsSM478UXOnO04ZA+Z6NzoehD+9jPv9f2qOB+4HKsfrWSX3v
         vE03MFZzWVxQUnH/d6yU0N3M5EsXJIX4L+16l1ynHUGQ6r7rbi5f6lCkt63a4xE6+x4b
         yzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825823; x=1683417823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+8kfy3tjKLPe3TifJTVuacG8Zo955zar201sEBpYQI=;
        b=yfEe9V6jo9DuPHDu7KgqvlzhXs0ak69W1iDl8sBwoqzNiaqUh8wzuD501tgMn4jAMo
         LSsFnUccrVsOUxJ5GmDKY8zWYW81krJgz2P0IviQ1ezVm5sCoDMJ9AzYi0ZV7KWs0vJ2
         Au1WDkVLNgwSzkfyalJkCTWZLQCkxI1MUfKci2C1p0zsbKDMlb2CTJa/QVmBKyceC/0+
         omnqvpTE0Ba3fNCUiH0pviaL2a9dL04xs6YP6l4NsAkqhlXIdqjdYcloCUoUo6ni3OpH
         J7lgiooACNnm68E6H7mSqMnR9+mmRZSRUU0LoBkn9D3S2BtlD2R4tmxzWwU0cKi4PdZ7
         fe0Q==
X-Gm-Message-State: AAQBX9eB0qzcI4PlvL43CtOBZ15cnzuH436F8Y7r0j5oXQFyPhHjmFZ1
        w/x5PPTm2rL6D0Xa7YA/+6dQIuEYpOVVX3Y6
X-Google-Smtp-Source: AKy350bZf3Pgmi2zLBkprnBI1EXh9QEM6UWQo+KFZnv2Ap/aVssuKQNynTVN5Pac7j4VHVTr9tnMlw==
X-Received: by 2002:a17:906:a18b:b0:933:44ef:851e with SMTP id s11-20020a170906a18b00b0093344ef851emr558038ejy.55.1680825823181;
        Thu, 06 Apr 2023 17:03:43 -0700 (PDT)
Received: from andrea (host-79-35-32-179.retail.telecomitalia.it. [79.35.32.179])
        by smtp.gmail.com with ESMTPSA id x5-20020a170906804500b008def483cf79sm1373504ejw.168.2023.04.06.17.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:03:42 -0700 (PDT)
Date:   Fri, 7 Apr 2023 02:03:36 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <ZC9d2DIOMy27AAT9@andrea>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
 <OS0PR01MB59224C99770F84D8CE2D0DBA86939@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZCxFUb8+eQPzqBmo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxFUb8+eQPzqBmo@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But other other point is adding more cache flushing variants should not
> be easy.  Everyone should be using the standardize version.  If it's not
> implemented in hardware despite having ratified extensions you can fake
> it up in SBI.  Yes, that's way more expensive than indirect calls, but
> that's what you get for taping out new hardware that ignores the actual
> architecture specification and just does their own made up shit.

FWIW, ALTERNATIVE_X() for "three instructions with (what should be a)
crystal-clear semantics" already smells like "we're doing it wrong" to
me, function pointers would be closer to "we're looking for trouble".

Thanks,
  Andrea
