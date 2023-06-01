Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5210E719F41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjFAOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjFAOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:09:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB4B195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:09:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d24136685so752252b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685628565; x=1688220565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LdetLaB3EwVUbbSqA0vU4H6NSoKt0z+r+Cp9X9P/A0=;
        b=gJisiFINMxWPneYy3izE+r2RnjBFQRHYx7BQSKqPo2zW8oVST3gk+wLjeZXK458PdK
         kJ4vVjI1yBBa/V/Z3/JGMYwijrWv4jyid06Wt5S3vzDDGC+8iCDmN83JXIUT+D7kWqGV
         jcptszXp0dECwm25IqViej04A6+sLSGriy3dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628565; x=1688220565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LdetLaB3EwVUbbSqA0vU4H6NSoKt0z+r+Cp9X9P/A0=;
        b=Aw+aonrjkNq89g7XVmaFzPMcIZhT1+8A5jkxRuBFe+DSSm0K+c5D49IJHVY8qee2eo
         MzPqTZwb8X0LS+cV9k2VhQWnNjOO/wm1ZvStYcAFTX7lsvvwU8olBv5zSkAPCL1v/w1V
         LcIQ66e75Lm8xOBhE++o42q/jlRx0Yq3Uqt0aOoW9ujHc2RVsQlhlBW5+cHl8oGzgDoa
         /2zoG5QUE97lJ3KQw3vZVJjZ2+U/Gk/Xtc5rVFyqEYS0DA8KxodtH86SqHt31N93e8hL
         u+OHnBuFNJwXB2D+SPT1ecEMEBN2N6JDzZJMHuLhHmguzIkeTyK/fftEpKUm6vWZPGca
         mKfw==
X-Gm-Message-State: AC+VfDze+iW+eMMET6DxPvWd6DeotJu9DZxcBQrAkMWhkNNxZl0qbdIb
        9NXKUVh3g05Fr1u78D9qh+khAw==
X-Google-Smtp-Source: ACHHUZ4FuTClHlKmXk04ba00hl87Wli2OV1TADotIUnvNoQ9ARrJBgJed+hibc2klzsbddB9z3IZYg==
X-Received: by 2002:a05:6a00:1f96:b0:64d:2a87:2596 with SMTP id bg22-20020a056a001f9600b0064d2a872596mr1660139pfb.10.1685628565229;
        Thu, 01 Jun 2023 07:09:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z3-20020aa791c3000000b0063d2dae6247sm5119795pfa.77.2023.06.01.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:09:23 -0700 (PDT)
Date:   Thu, 1 Jun 2023 07:09:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     arno@natisbad.org, arnd@kernel.org, schalla@marvell.com,
        bbrezillon@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/cesa - Fix type mismatch warning
Message-ID: <202306010709.B6942DFA8@keescook>
References: <20230523083313.899332-1-arnd@kernel.org>
 <168548692863.1302890.6789778742527600870.b4-ty@chromium.org>
 <ZHcoQvWnzO0c1Cp9@gondor.apana.org.au>
 <202305310930.844EBEA21C@keescook>
 <ZHhwfVH3pldZohHC@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHhwfVH3pldZohHC@gondor.apana.org.au>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:18:37PM +0800, Herbert Xu wrote:
> On Wed, May 31, 2023 at 09:31:18AM -0700, Kees Cook wrote:
> .
> > I snagged it since a week had gone by with no additional discussion and
> > it fixed an issue exposed by work in the hardening tree. Let me know if
> > you'd prefer I drop it for you to carry instead.
> 
> Yes because these sort of changes cause unnecessary conflicts.
> It's not as if the patch depends on something in the hardening
> tree.

Done! :)

-- 
Kees Cook
