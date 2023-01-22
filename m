Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8C677385
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAVXlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjAVXll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:41:41 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DCD8A59;
        Sun, 22 Jan 2023 15:41:40 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 98F6F1F569;
        Mon, 23 Jan 2023 00:41:38 +0100 (CET)
Date:   Mon, 23 Jan 2023 00:41:37 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] iio: adc: qcom-spmi-vadc: Propagate fw node
 label to userspace
Message-ID: <20230122234137.fyziba55n3b6tx3j@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
 <20230122165947.62e8652d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122165947.62e8652d@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-22 16:59:47, Jonathan Cameron wrote:
> On Mon, 16 Jan 2023 23:09:04 +0100
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > Implement read_label in qcom-spmi-vadc to see DT-specified label names
> > in userspace.  At the same time clear up some documentation around
> > extend_name to promote read_label, and normalize similar code in
> > qcom-spmi-adc5.
> > 
> 
> I think this is a good route forwards, but it is making changes
> to ABI so I definitely want input on this from at least one of
> the qualcomm maintainers before I pick it up - particularly
> the changes in patch 3.
> 
> Don't want to cause anyone nasty surprises.

Ack, patch 3 is the odd one of the bunch (as discussed many times
prior).  It is an ABI break and would effectively obsolete "iio: adc:
qcom-spmi-adc5: Fix the channel name" [1] as it then only affects a few
dev_err/dev_dbg.  Let's wait and hear from Qcom maintainers.

[1]: https://lore.kernel.org/linux-arm-msm/20230118100623.42255-1-andriy.shevchenko@linux.intel.com/

- Marijn
