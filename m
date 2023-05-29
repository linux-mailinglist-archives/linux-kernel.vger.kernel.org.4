Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB39714CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjE2PBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2PBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:01:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52244CF;
        Mon, 29 May 2023 08:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685372461; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TeSUgNsviWgTVrVSnU40bV5R/cHXanV8tma+FMDWJlFy/71IT2GJbWPRagVA4NQwNA
    U2ar3rZ7ByCtIUJkxe2g8RJg+1NkKwDZb9zlDLzD/rtxWbDcjKl7wBv0GmgRSmTUVj0I
    /jHTpsVYX8ONHGRP37yAzCHcdyl9ng99+91LOMHZjDiDG9/YfN4foHPPfMhIqF+ypujT
    x3nbqf6l+Ki8oZ5Vvw7DVnvD5dmV/pB0Y6YvdH0lNOL1wBBSes9rPOgOUALT9/UiJz/5
    hvAY0A+f11uYKGAL2NyCHm/I+sym7A9r40w1TBSJsdgUAghRMsVpzlTAlHoZAo1PyWei
    OQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685372461;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+wzkjf8akFN6Ea02ez3eZdGqus6ezvmNm9bS8kdiMx8=;
    b=XTcMGJnBfgpSQgRe+XfoonK10OwsghMyvsYOJehUEpTz1q+Gv1mSvJioo1Bed9TrPK
    4fQL+mbQZ+NlfAF1vjU1YSq9BVqfbK8xps6fAeghVR0N9cfl5VeZ89qwI1sAR17c+EXX
    QBVMBfuiQRw0meo2K0+erwamfhVvzcQtt60eVpUZASJzUM/PHER6BOg4btEFX1gaRE6b
    mRodUGiXgkl7hZLU/WkolSji0cloSdx5b7DLJ0nZSQEssviIP8wnNumvW4nv96/qS9ao
    TEf132f8ToXwGdht9NEoxGPfZDBVY0Ctq8eNbAm6jvW2MsEtccsxkYGpt7oktyTKtgzi
    9UHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685372461;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+wzkjf8akFN6Ea02ez3eZdGqus6ezvmNm9bS8kdiMx8=;
    b=gusDTWrkNZ8aDk1NpbmhIdjLnDMM4zvSOq02AZuzseqzID870u/wLJzaUBqT3ZHxYx
    cmxOdbLEatwg1zCgdpzpKuaxWrQTvsTvGUpxEdD7W5euRhkVfTtaGeQWNmaGS8XMmTf2
    A17eJGic66xwvwdirNxM8XiErxqah7DGpqyFVvGlAgpwBustTBUtRK6+LwCdpl8rGLNL
    83VqVjLk32/jDinCtv3wE5kLAbdxA2n+a3WK1nvS2IVQtfJ+u9fNDZl7hWSTu3iR/MDL
    dNov97kaMNqnUBrySFZQ0W3yuZ2A3A8nFnJI+JY9mAmFUtljs158UUjxoZS/i+uwnnah
    y1hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685372461;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+wzkjf8akFN6Ea02ez3eZdGqus6ezvmNm9bS8kdiMx8=;
    b=MWRN6KEIuGY+fuwWaRj5s1FHHvee/GDJ55nXozFI/eWsP1n3neRqT0nk/vabIjbQs9
    IaefzQIO4D/sNjM90oBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8pqP1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TF10fFG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 17:01:00 +0200 (CEST)
Date:   Mon, 29 May 2023 17:00:54 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: msm8916/39: Clean up MDSS labels
Message-ID: <ZHS-HSgaBxMXiKy9@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-4-bec0f5fb46fb@gerhold.net>
 <6f1954e6-e98d-6911-8721-c50082bfb1d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1954e6-e98d-6911-8721-c50082bfb1d7@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:33:43PM +0100, Bryan O'Donoghue wrote:
> On 29/05/2023 13:47, Stephan Gerhold wrote:
> > Right now MDSS related definitions cannot be properly grouped together
> > in board DTs because the labels do not use consistent prefixes. The DSI
> > PHY label is particularly weird because the DSI number is at the end
> > (&dsi_phy0) while DSI itself is called &dsi0.
> > 
> > Follow the example of more recent SoCs and give all the MDSS related
> > nodes a consistent label that allows proper grouping.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> 
> You should probably churn the yaml that goes with this..
> 

Do you mean update the examples in the yaml bindings or what exactly?

Will take a look at those in a separate change (DT bindings don't make
any definitions about labels so it's not strictly related). From a quick
look it even seems like the labels are even omitted mostly in the
bindings.

Thanks,
Stephan
