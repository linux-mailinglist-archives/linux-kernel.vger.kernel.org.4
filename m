Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA55FAA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJKBfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiJKBeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:34:12 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D84A7D799
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:34:10 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 87FDB1F40B;
        Tue, 11 Oct 2022 03:34:07 +0200 (CEST)
MIME-Version: 1.0
Date:   Tue, 11 Oct 2022 03:20:45 +0200
From:   konrad.dybcio@somainline.org
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: dispcc-sm6350: Add CLK_OPS_PARENT_ENABLE to
 pixel&byte src
In-Reply-To: <20221011010234.5309BC433C1@smtp.kernel.org>
References: <20221010155546.73884-1-konrad.dybcio@somainline.org>
 <20221011010234.5309BC433C1@smtp.kernel.org>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <dc7b1e2cb4c6b59a541505d61970774b@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-11 03:02, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2022-10-10 08:55:46)
>> Add the CLK_OPS_PARENT_ENABLE flag to pixel and byte clk srcs to
>> ensure set_rate can succeed.
>> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
> 
> Any Fixes tag?
Sorry, I keep forgetting..

Fixes: 837519775f1d ("clk: qcom: Add display clock controller driver for 
SM6350")

Konrad
