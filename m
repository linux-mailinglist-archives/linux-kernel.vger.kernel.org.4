Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5426FF7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbjEKQoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEKQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BBD5583;
        Thu, 11 May 2023 09:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E1D864F81;
        Thu, 11 May 2023 16:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCF7C433EF;
        Thu, 11 May 2023 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823438;
        bh=Wqh19kXAF8yYrXdxuIWIOAmT5E8KqeIH3y/wfx1IDwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sf2APbricodUQsSWBjLHUeZt4hS/oDJUDWlrKoalAVFu4BkpN1TBjBq3caMBCU1hj
         CM1ezs2FJ73DnZvhXdydm6CulLdLy9NnfmnPehE75vSfdfnsEtrnToJTtvHUdkoXLM
         Q0TcU64O7SctObJYkFPl7I9FEBuOQHVF/iwEkuJLaeDC5rKCa/zzQHZ04toJnzCHrS
         uNNziNmfW0KvJEUkUj/QX+Ba5aYF7DNVKbl1/PE/O9Y6f+B8UqQdeu3ITGOe7OGWbk
         8YyTicDg2/v2tHYcAtMrinSXVBmJ6Ts5jYTRflvsyZNgKYPuQK5+lmKHdP25sQJxni
         fG9S633YyVzDg==
Date:   Thu, 11 May 2023 09:47:34 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable TYPEC_QCOM_PMIC
Message-ID: <20230511164734.unkectw5yma2mqav@ripper>
References: <20230511135503.198538-1-krzysztof.kozlowski@linaro.org>
 <016ab311-cc66-b1c7-4099-f63e8f3644b8@linaro.org>
 <ca7a8499-0ac9-43d3-45ab-c974b1a2a564@linaro.org>
 <CAA8EJpptzh1w5-WgybEOOa59PTgo5z7CEr5vstWwhH7naBttjw@mail.gmail.com>
 <40d8c92e-458e-ace9-2fab-6fc3da580221@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d8c92e-458e-ace9-2fab-6fc3da580221@nexus-software.ie>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:26:20PM +0100, Bryan O'Donoghue wrote:
> On 11/05/2023 15:52, Dmitry Baryshkov wrote:
> > On Thu, 11 May 2023 at 17:36, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > 
> > > On 11/05/2023 16:14, Neil Armstrong wrote:
> > > > On 11/05/2023 15:55, Krzysztof Kozlowski wrote:
> > > > > Enable CONFIG_TYPEC_QCOM_PMIC necessary for full USB Type-C support on
> > > > > Qualcomm QRD8550 and MT8550 boards.
> > > > > 
> > > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > ---
> > > > >    arch/arm64/configs/defconfig | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > > index a24609e14d50..8b6407d2059d 100644
> > > > > --- a/arch/arm64/configs/defconfig
> > > > > +++ b/arch/arm64/configs/defconfig
> > > > > @@ -991,6 +991,7 @@ CONFIG_TYPEC_TCPCI=m
> > > > >    CONFIG_TYPEC_FUSB302=m
> > > > >    CONFIG_TYPEC_TPS6598X=m
> > > > >    CONFIG_TYPEC_HD3SS3220=m
> > > > > +CONFIG_TYPEC_QCOM_PMIC=m
> > > > >    CONFIG_TYPEC_UCSI=m
> > > > >    CONFIG_UCSI_CCG=m
> > > > >    CONFIG_TYPEC_MUX_GPIO_SBU=m
> > > > 
> > > > This driver isn't used on SM8550, only CONFIG_TYPEC_UCSI is needed.
> > > 
> > > Indeed, apparently I messed something with config while looking for
> > > other options. Patch can be skipped, the driver has no users in upstream
> > > (and bindings are still missing :( ).
> > 
> > ... And it will be hopefully removed by landing Bryan's patches.
> > 
> 
> I actually reuse this CONFIG option so I can stack this commit last in the
> series - it will just switch on the new driver instead.
> 

Please do so, I will ignore this change for now.

Thanks,
Bjorn
