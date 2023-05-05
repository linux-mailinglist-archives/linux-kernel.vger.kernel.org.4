Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708826F843A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjEENii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjEENie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:38:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806421541;
        Fri,  5 May 2023 06:38:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so1960641b3a.1;
        Fri, 05 May 2023 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683293912; x=1685885912;
        h=in-reply-to:content-disposition:content-description:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mz4evSv67hQPNV6oClHQJu53Y2013LybJpvcP/3rYWU=;
        b=TBySTqTx6D329de6pIqxKPksV2SP41ErBZxOvFEAhZ5kQlqc0eJ5/NbmGyaT4gtAju
         Oqxh0fnWWcFFq4pNWDjDgouY3OBBklA+9z1iUZUrpcoYjGmg6/KsH0CLeysDBpOMz/aU
         5eqSMf9WIUB2NYcqtw+h0eYBE6qcZ9V2YJts8jZkI4LF6MmEfeE431yfjdpA25Cv6nyC
         gXXvu3e/LRKDwx8589uKdf4AeEkU5fp7oLRV7FvTI8I1yMlgxjEKIlJ6Gmi4DESPBnFL
         h/6e0zLmZoqPcL7VitXcgTUcex8Rsq9uzMEDyW7jgbljTJ3I9ja3MLMYKVXYoLSJ7Ley
         uJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293912; x=1685885912;
        h=in-reply-to:content-disposition:content-description:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mz4evSv67hQPNV6oClHQJu53Y2013LybJpvcP/3rYWU=;
        b=PdmgzNNu14XAh/V5lf3zbPQc8Wuhopj9fissTsLeS5pp1cZPYBbY/daRfqlMTGffai
         Ua0BKYJ82sw95QeKoeznP0WQ7i9MAHatmCl4lvAqxMemtemxkgjFHZ1CV7BJ0nUUmhqB
         fY3Xcb4qCYqiPrd6eozGb4lFPyvk+/r1taqE4DYRMdMhyMItgW5WEKlkmEAEZ9mdiBxI
         Gg2IZPUqvvaHY0HggPfYDGNIYRp3mwz0xURO0FQu5GGHhOd8LIt4p3DoEqAis4iIDFdp
         NMUZ/nSMRFjxVplxOuwe4DzCTX1WkSRtV16pVExNF61i5Frxh75neaJjPzJ98wNwQT0k
         F7tQ==
X-Gm-Message-State: AC+VfDwcZNA2qA8jPTQhlfOLltXrplixH/UZ6N6ZHZ3pNgRoQJcjEO5A
        41cV+woaZO/CODo7n9R80dQ=
X-Google-Smtp-Source: ACHHUZ6jqvBp3DoOq6QbmnOZPC1jBE589QcBJHn3Ic731Vt39CAjAls8FFVH+ZQr5GZDp92TA0lpEg==
X-Received: by 2002:a05:6a21:6704:b0:ef:ed72:779c with SMTP id wh4-20020a056a21670400b000efed72779cmr1761265pzb.8.1683293912071;
        Fri, 05 May 2023 06:38:32 -0700 (PDT)
Received: from yoga ([202.131.133.155])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a6c8200b0024e135c2ea1sm5248770pjj.18.2023.05.05.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 06:38:31 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 5 May 2023 19:08:26 +0530
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        oder_chiou@realtek.com
Subject: Re: [PATCH] ASoC: dt-bindings: rt1016: Convert to dtschema
Message-ID: <ZFUG0vZG68hjZ0n9@yoga>
References: <ZFUFAmBJXvkQAG7m@yoga>
 <ZFUFrWqOHVmzE+ut@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: evicetree@vger.kernel.org,
Content-Disposition: inline
In-Reply-To: <ZFUFrWqOHVmzE+ut@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 10:33:33PM +0900, Mark Brown wrote:
> On Fri, May 05, 2023 at 07:00:42PM +0530, Anup Sharma wrote:
> 
> > +maintainers:
> > +  - oder_chiou@realtek.com
> 
> If you're nominating someone as the maintainer for a binding it's
> probably best to copy them on the patch so they're aware...

Thank you, will keep that in mind. 


