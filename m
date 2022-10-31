Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA98613F82
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJaVJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJaVJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:09:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FE1400A;
        Mon, 31 Oct 2022 14:09:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sc25so32504154ejc.12;
        Mon, 31 Oct 2022 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/H4zqvSpNZbUP7OdRkQB5ulns/JJgEm2p5HDGl4vr0=;
        b=jdQru/ANuLfpXnbBWcPf+Hnh1EQl7quPemjaS+7RJyGqhJwwB6igUuSq9pNxYcak0A
         O0nU+ktQjuDbpEPhSNuMVISijVcd+pIqtLohl/p0ipwDMxlxu/kPw1UKYXC9AtARimqh
         gOdvhpfEA53WAhFgMb0x3OQ2og6243Ss4vzxwpbFzmrCXZ+akwiLuHMgHFE7Nq6QAvxZ
         RWt4SDvHeG6V0iGYZUBbIa2fDRVKuFVryFwygqPVV8OHEkLB/3JPy+4NUwLxouKhDe9C
         nYvGm5nCci9SEfvVOQOPKfIBUcy4654RF5o2cE3b9PaxeCf+U2MrcosGsShH9K4TNIwL
         lBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/H4zqvSpNZbUP7OdRkQB5ulns/JJgEm2p5HDGl4vr0=;
        b=fO/7ENJVb8fjSH/AffvJ6Z6pFyyjI+mwCsRkbWHn0TVmoRCiDkqF9K3iIkkxAgB5p7
         Gmg3cVo8iKp3A7B2vxITheTEbUXmRe9CftG+/cyaa+sEDxGLYq5upkTlTGY50OwnK776
         ociw/AyHidB4TaHw0axz3sPvpAd+I7Q/aoH5aIfMuzVX+WWTPxJGjeMOF9HBoKx4kKv6
         y7TXvmdamg4hwzkF5JDOCqKmcL6sg2+ZCSeNepCIZz1QDZKVhtOKU9dFlbmlV3rrqxPj
         kNEBaVyBsqnNV7c5oAsa6jupWiaES3VzBCzXuBUsbGsJzcvFRskx69+2NJAfNmq1dQdd
         VTDg==
X-Gm-Message-State: ACrzQf3uVhX9o3scFlkvBo5rinCuGlSjr8RlSFLJ0YQIDs+KtKggaWRk
        u1hGj/t+BrLmGMAz4MYtO594Ka2Aqd83dJVSrsk=
X-Google-Smtp-Source: AMsMyM5+ph4B22ErqbAdNIR0yHm97b2v08YYH+tQJokufHWxnNOdwM3zHZFAfKxK7ZqKFho9BCmRd/EZctEN/41ixx0=
X-Received: by 2002:a17:906:401:b0:73d:af73:b78 with SMTP id
 d1-20020a170906040100b0073daf730b78mr15533535eja.122.1667250578007; Mon, 31
 Oct 2022 14:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221031091918.531607-1-pierre.gondois@arm.com>
 <fac3eae5-687e-9eb0-ddfb-c659d3816d81@linaro.org> <3c54db0a-44fe-ee24-1833-7637e249ec79@arm.com>
In-Reply-To: <3c54db0a-44fe-ee24-1833-7637e249ec79@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 31 Oct 2022 22:09:26 +0100
Message-ID: <CAFBinCBi_xT-pgdMSROHyZUfyZZE33S2YXczr9ijE52AfQVYHQ@mail.gmail.com>
Subject: Re: [PATCH 02/20] arm64: dts: Update cache properties for amlogic
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     neil.armstrong@linaro.org, linux-kernel@vger.kernel.org,
        Rob.Herring@arm.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Mon, Oct 31, 2022 at 2:33 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
[...]
> To avoid cc-ing people to DTs they are not related, the get_maintainers.pl
> script was run on each patch individually. The cover-letter is at:
> https://lore.kernel.org/all/20221031091848.530938-1-pierre.gondois@arm.com/
I think Neil's question is the same as mine: is there a dt-bindings
(yaml schema) change for this as well? The idea is to alert people (or
let bots alert people) in future when adding a cache to a .dts{,i}
where the cache-level property is missing.

[...]
> >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Your patch looks good to me. We already use the property on the 32-bit
Amlogic SoCs. So please add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
