Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06165B400
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjABPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjABPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:17:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4A1A1;
        Mon,  2 Jan 2023 07:17:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB03DB80D6E;
        Mon,  2 Jan 2023 15:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF86C433EF;
        Mon,  2 Jan 2023 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672672670;
        bh=mfhBW/C2IWmFe9h/eJYL9IdzGPL6NogFGe45WS96J7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7rwt0Nyjyr/zK7P5nU1QDTi28q9FWC9V7gDZ1/fW+a04WfEe4QMjUiYXk/7gVuV4
         Z3qBsDVvUC7qkZiiXUWkPdihuwdlgQne/VOQvB+fwjd/vlWW5AvPJXICA3duyULwUZ
         uf490cMqMSiC3JFAyVDodGE58FXIgGHufcwILMOSDeAemjDfa/9g9yShealOC/ru5B
         PMr9zwAgQ4FD4X87Dj9e7yzqww2syNCfPcFqOdvW2U8EJ6t9g4ln6ISRPwqg3qdl/k
         mmBdoiMRuanaPY1o8IfFxxAy8vih2URpXOabOeQ5Vi2Q3LlxNYKPIIl5Mu4LUZaC6c
         ESScQM/S8ZvBw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMZj-0007v0-Rp; Mon, 02 Jan 2023 16:18:07 +0100
Date:   Mon, 2 Jan 2023 16:18:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
Message-ID: <Y7L1r7ehoo68ZxJQ@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-6-johan+linaro@kernel.org>
 <1a8226ef-b16c-e713-94bd-807ca356ef8b@linaro.org>
 <Y7LyQZ6FotC5Rpmg@hovoldconsulting.com>
 <ae0499ce-f4a2-22a8-840a-6d7640079b93@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae0499ce-f4a2-22a8-840a-6d7640079b93@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:09:14PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 16:03, Johan Hovold wrote:
> > On Mon, Jan 02, 2023 at 01:20:03PM +0100, Krzysztof Kozlowski wrote:
> >> On 02/01/2023 11:50, Johan Hovold wrote:
> >>> The wcd938x codec is not a memory-mapped device and does not belong
> >>> under the soc node.
> >>>
> >>> Move the node to the root node to avoid DT validation failures.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
> >>>  1 file changed, 19 insertions(+), 21 deletions(-)
> >>
> >> Don't you base on some older tree? It was alreadt moved. Maybe other
> >> changes were also implemented...
> > 
> > If you've moved this node is hasn't made it into linux-next (or the qcom
> > tree) yet.
> 
> So you need to update your tree/rebase as this is already in Qualcomm
> tree. There was no linux-next release since a week, so that's not a
> solution.

As I wrote above, it's not in the qcom tree either.

Johan
