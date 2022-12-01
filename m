Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E437F63F805
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiLATTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLATS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:18:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C30DB3915;
        Thu,  1 Dec 2022 11:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F39CB8200E;
        Thu,  1 Dec 2022 19:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D94C433D6;
        Thu,  1 Dec 2022 19:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669922335;
        bh=hSbyl0ectETj26ZvTfkUVS3Ig7lwtSaBLWBZQNFnGEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIh5KC85iyhQHOcd1Y+TJD2FNxeFNz/xIsEmQYxsyo6u9YAuICqU90jjtn4vml5nJ
         ElRBusQir3H6DtBSIZLG8+r6nVUAQTfRD7seZEvqAW/ejW/kfOZZEqikR7u2Wa0EnA
         pg9aykowp5fJTN573QEZAAL/6EeQqIkfgFf9jnGSQohnT2V4hKgvawIrmJI64Q9or/
         gFMd2xuOgtHUQZQ1R+nIhwj6WugMl9VNiCd1WbBYglfQCnQKoYqxebeG8AHlKXI9Jq
         XE8WZRjGwqfnWCkaG4B0s75QRNVBH4ARbJLSM1wlB2gUGygu1hSPbdtko3aEeThEe9
         CJV7JuYf8RaOg==
Date:   Thu, 1 Dec 2022 19:18:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>, Icenowy Zheng <uwu@icenowy.me>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for
 OpenC906
Message-ID: <Y4j+Gpptk3NAFBNV@spud>
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-3-uwu@icenowy.me>
 <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
 <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
 <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
 <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
 <20221130181330.GA2544489-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130181330.GA2544489-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:13:30PM -0600, Rob Herring wrote:
> On Tue, Nov 22, 2022 at 03:41:27PM +0800, Icenowy Zheng wrote:
> > 
> > 
> > 于 2022年11月22日 GMT+08:00 下午3:35:48, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 写到:
> > >On 22/11/2022 08:18, Icenowy Zheng wrote:
> > >> 在 2022-11-21星期一的 11:06 +0100，Krzysztof Kozlowski写道：
> > >>> On 21/11/2022 05:17, Icenowy Zheng wrote:
> > >>>> T-Head OpenC906 is a open-source-licensed fixed-configuration of
> > >>>> C906,
> > >>>> which is now public and able to be integrated.
> > >>>>
> > >>>> Add a compatible for the CLINT shipped as part of OpenC906, which
> > >>>> should
> > >>>> just be ordinary C9xx CLINT.
> > >>>>
> > >>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > >>>> ---
> > >>>>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
> > >>>>  1 file changed, 1 insertion(+)
> > >>>>
> > >>>> diff --git
> > >>>> a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > >>>> b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > >>>> index aada6957216c..86703e995e31 100644
> > >>>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > >>>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > >>>> @@ -35,6 +35,7 @@ properties:
> > >>>>            - const: sifive,clint0
> > >>>>        - items:
> > >>>>            - enum:
> > >>>> +              - thead,openc906-clint
> > >>>>                - allwinner,sun20i-d1-clint
> > >>>
> > >>> Add entries sorted alphabetically. This should be squashed with
> > >>> previous
> > >>> patch.
> > >> 
> > >> I make it a seperated patch because I think it's a questionable
> > >> approach.
> > >> 
> > >> If you think it's okay, I will just squash it and put it as the second
> > >> patch in the next iteration, with adding openc906-plic as the first
> > >> one.
> > >
> > >What is a questionable approach? Why commit msg is not saying this?
> > 
> > Ah I mentioned it in the cover letter. The problem is just I doubt whether
> > binding strings for single SoCs are necessary.
> 
> They are.
> 
> Unless all the quirks/bugs/features are somehow guaranteed to be exactly 
> the same as other SoCs sharing the same compatible string, or there is 
> another mechanism to identify the exact version (e.g. a version 
> register).

Icenowy,

Having thought about this a little - are we not *more* likely to see
bug/quirk disparity between implementations of the OpenC906 stuff by
the very nature of being an open-source IP?

Thanks,
Conor.

