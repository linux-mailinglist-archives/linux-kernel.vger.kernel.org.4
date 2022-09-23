Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB795E82B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIWTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWTuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:50:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE411E5CE;
        Fri, 23 Sep 2022 12:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695AB6163D;
        Fri, 23 Sep 2022 19:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD8C433C1;
        Fri, 23 Sep 2022 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663962631;
        bh=RfJloGo0sbd9e1QwXzBADCE3z3aKJNEikzCN2JIketA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KO4oDSwG+E7Z1PjhWQDpf2PLjdM/xNJ3eQ8syIQlTPeK72uSrWQ/DE3VB1pNirur2
         Gzj8lDjDBh2ISy6WL4eHZ8MUG7C2lcXtPLVOwzoWlnGvLcqugUAfrOfkrhSpEWT5tK
         DwrlKaQhzwlOyQ+Od30AeP0TWkDMp4L/Geb75Kr5OPm06WJ255+/KPL9Ycoq/UkU1B
         N4Aa68UxBS2oq+vEB5ibeQ/AqLu4+orjyvpoCGDwc7VhWH2EkAp8U1/Gd8cmp6fpLA
         zWPZf0nuSqK9ZGfisuL4V1hIHZWWxQs3HhJfINCiScLejy1Ip0KHsjn5TR0C5ZS8Lb
         dvi/RhyZT3Y/w==
Message-ID: <1e62bea8-601e-fb48-d75b-4d8ed08fae16@kernel.org>
Date:   Fri, 23 Sep 2022 21:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V13 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <44ca04316e8b67f1662d304d8535236d82710bda.1663642052.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <44ca04316e8b67f1662d304d8535236d82710bda.1663642052.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 05:56, Souradeep Chowdhury wrote:
> The DCC is a DMA Engine designed to capture and store data
> during system crash or software triggers. The DCC operates
> based on user inputs via the debugfs interface. The user gives
> addresses as inputs and these addresses are stored in the

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

Best regards,
Krzysztof

