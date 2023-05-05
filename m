Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084676F8ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjEEVZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEEVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:25:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59F5BA6;
        Fri,  5 May 2023 14:25:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ac4dd11bso448906466b.2;
        Fri, 05 May 2023 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321914; x=1685913914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PVt2/GzWyz5Ess7y+OCZ33ZvS4WPkfBPz+s8yoY7/9o=;
        b=cBhPsq7jc79GPzYqA9o+PUh5onUk8i5uaj49kXEhrw/1lEyz5LxLW/7/fVWlojfhKK
         F/8GRStnKtjRe8D3XJpOieqLlOBSAwYFMxUU2YiPGwfDQNplUTfZ6jz7LmZrfojhrFMY
         Hhgj9ov39uVCjETc9guBXenKjp3+W0YC7xT/a2TTlJUk1v3MOK5XvT/UChQYX39DE3il
         eWK0qiavlThnGZPE/Au01gwhHp1NVu1FD8vgzIc4J5lZGDsJTMlLe6zvM1IxGyT4fSS9
         Hr7e/LSBMx5Ek302/V8iR0+9eJk3iL7W9Sit+dXKZQl+iXl+CLuhGZrMbWYbr1rJGWBL
         N+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321914; x=1685913914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVt2/GzWyz5Ess7y+OCZ33ZvS4WPkfBPz+s8yoY7/9o=;
        b=UT9WN/W8UJiuh171K3mNaCt8B/4j/Tznj3Aob5IRUAGgaK162fm7FK5Gf0KzZTHIrl
         hToOr+XtZ4BvClVfThEl1cZfo85Qj0TcUIH6bk0/I7os/92nFZSk+BtJnpxeKHKdAe60
         PPeLIEiKHWBUBwGeJtrAKRitjSaxXc05zhGtjJdYVSVkpRPjcbMBQp5T92vH48Uzrpha
         tmMTs2l8ckih+c3SMuJ7bRHVmeV470s7jja37eIBWgK9scZp5Xn3nojWxZihYSOUmVRe
         brU3luroGsKb7PeRLBWZwhOBxhD+U8DjlGeKApkXUpN6Nm5QKO9M6U89a5GARaoBC3f9
         15jw==
X-Gm-Message-State: AC+VfDwrckHyAt4hoXBF1CyQ+Gw+RvKWGRvZsIjffW11x3HgsgGhaye+
        S8cTPklFGAu2c3v/WwcJYBxBQQGimtc8lO00pyM=
X-Google-Smtp-Source: ACHHUZ4uG8c0N6L9crKfvVhzWNWIj4OGzXKzRUKG1CM3TRYjrUABbTN/yhe0vAftEiN/MCLVhaCovH677AnMW9adMYk=
X-Received: by 2002:a17:907:d86:b0:953:42c0:86e7 with SMTP id
 go6-20020a1709070d8600b0095342c086e7mr2517436ejc.4.1683321914389; Fri, 05 May
 2023 14:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230505074701.1030980-1-bigunclemax@gmail.com>
 <20230505105805.548d1a1b@donnerap.cambridge.arm.com> <CALHCpMi8=t1bMceTOfZjh7aKEQcEEpfeG4wi9pB=5o34Ca+N3w@mail.gmail.com>
 <20230505170015.664c18bc@donnerap.cambridge.arm.com>
In-Reply-To: <20230505170015.664c18bc@donnerap.cambridge.arm.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 6 May 2023 01:25:02 +0400
Message-ID: <CALHCpMiwqkMRV2Nv0sKG8ZD2D6jbjVaB6_jcShf6hMBUP3D3Dg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add SPI0 controller node
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, icenowy@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please try these patches, and use:
> compatible = "allwinner,sun20i-d1-spi", "allwinner,sun50i-r329-spi";
> for the compatible string?

I tested my patch (with compatible prop changed to
allwinner,sun50i-r329-spi) on top of these patches and it works fine
for me.

> If possible, you could revive this series, and add the D1/T113s support on
> top: just add the compatible string combo to the binding document.

Just one question. Should I do it now, or is it better to wait while
Icenowy Zheng finishes work on the next revision of this series?
