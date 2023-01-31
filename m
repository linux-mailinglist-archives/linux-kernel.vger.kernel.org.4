Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7E6821A1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjAaByt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaByr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:54:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2535BAD;
        Mon, 30 Jan 2023 17:54:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87C20B818C2;
        Tue, 31 Jan 2023 01:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44775C4339B;
        Tue, 31 Jan 2023 01:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675130084;
        bh=WMCwzZgJ1YbJBdlfXIpWHFykuZ2cmmCcqfyeC4dCrcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ClfiIbJbB3lVygcMuJixYIgclkEw5JW43OoTVjO2xBixX2by4/xiHi++SVmOCD/D+
         QIb6S0pG7YxlTqOZrmvCZ2SxFf/If04gZaFIYoJC552MzJ4nHazopGr1nIy8c+z6+j
         wTwLHlDsRo5BLAsbIK7Apl/TzcDJ5WsnCRKv5XKjprAEsVDIiyPfGxvhUuvRHPEo48
         HEZSbSpU++CtoSQYwMarwl5w4u80RHWhyEXPj3XyJJw+CW1vW+IdsY8cKTZpqlbQG9
         FYQ8sX38fSTmrBIdQUDTeCS1xMBn0Qk1TwfawuLJ62Q1x9FYiu1U58GGD46LuFRANh
         uS6XmtNWMBoow==
Received: by mail-oi1-f171.google.com with SMTP id o66so11694240oia.6;
        Mon, 30 Jan 2023 17:54:44 -0800 (PST)
X-Gm-Message-State: AFqh2krIpILXAJGnrMDP+qeYXxsWYe04I6BWtiKzFGfLY4bwCkB/8PK8
        tBJHUeBRwlFfseN+o8XG38D+39is+GtxLqxpb7g=
X-Google-Smtp-Source: AMrXdXuL2nVF2P6m9vnTUZF5t5sV3la2WCl1vykoQmwOCuazvt+UsAdlNHUlDUFOyQBlIf9kxE7CXtlxPe2vDgnKKAk=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr3175147oib.287.1675130083530; Mon, 30
 Jan 2023 17:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20230130162650.399490-1-masahiroy@kernel.org> <CAL_Jsq+e15e64Vsg8SwDsrUfzS8rWKi_39ajp3=2Ck7Dz_gs5A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+e15e64Vsg8SwDsrUfzS8rWKi_39ajp3=2Ck7Dz_gs5A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 10:54:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZwt=WpmTwWV0Kp2q4hAvGGhCVDWf-xBpWCkn98AF7mA@mail.gmail.com>
Message-ID: <CAK7LNARZwt=WpmTwWV0Kp2q4hAvGGhCVDWf-xBpWCkn98AF7mA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rename .yamllint to yamllint
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 4:53 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jan 30, 2023 at 10:26 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This file is ignored by git by the '.*' rule in the top .gitignore.
> >
> > I do not see a good reason why this should be a hidden file.
>
> Only because that is the default name yamllint will pick up if it is
> run from the bindings directory. Not really something I do though.
>
> Rob


Or, do you prefer adding

!/.yamllint

to Documentation/devicetree/bindings/.gitignore  ?




-- 
Best Regards
Masahiro Yamada
