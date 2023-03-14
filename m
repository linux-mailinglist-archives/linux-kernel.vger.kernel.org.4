Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B86B8C26
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCNHp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNHpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:45:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A13E144A1;
        Tue, 14 Mar 2023 00:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5504AB8169E;
        Tue, 14 Mar 2023 07:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2F7C433EF;
        Tue, 14 Mar 2023 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678779892;
        bh=ORCBIFi6Wr4t3+HBvEF5ChTEEJl+lMEmg3a1qR/3bK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRK2X/TsGyyPp7KUzsB1UM8eibPwZOqrf3lrdehlq9X3KiKW8jBzKUJx2FNhpOn4q
         bCGjtQstbDhu3yWtIB5uIiSD+x6+ZFT3jj7BfT0wShnQo5YUVQrcGaiP7RtHazrSDK
         b5S751CNtnG5+kRDXqbCwBmnKVS4mOIzjgFPQQUho2ZVGyJNGYTeNOZTO573Lb3r5B
         RUzFLU0XlppId5ky9xya2prcunJ9wZvA+HJKmaWRGDULCyqR9ejrPUuN0+/YnJT3oa
         hkQ6g4CYjUIcM8TmMlMGOxB1/nlQOJNww825PZmLQzd6YYt+qBh2PZzBqSkrcMeGHq
         05zKEFWDrtYSA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pbzM2-0001Yu-Au; Tue, 14 Mar 2023 08:45:55 +0100
Date:   Tue, 14 Mar 2023 08:45:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] interconnect: qcom: rpm: fix msm8996 interconnect
 registration
Message-ID: <ZBAmMoV3dOUxBgo+@hovoldconsulting.com>
References: <20230313084953.24088-1-johan+linaro@kernel.org>
 <3995e6b4-b222-6152-0292-29ed3704de02@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3995e6b4-b222-6152-0292-29ed3704de02@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 09:57:37PM +0200, Georgi Djakov wrote:

> > Georgi, the offending commit is currently in your icc-next (and local
> > icc-fixes) branch. Perhaps you can fold in the fixup unless you prefer
> > applying it on top.
> > 
> > The bogus PM domain lookup is redundant and confusing but should
> > otherwise be benign so the removal could be applied to either branch.
> 
> Maybe then I'll just drop this:
> 	interconnect: qcom: rpm: fix probe PM domain error handling
> and apply this one instead:
> 	interconnect: qcom: rpm: drop bogus pm domain attach

Sure, that works too. Wasn't sure whether you preferred incremental
fixes on top or not.

I've checked the end result in linux-next against my local branch and
everything looks good.

Thanks for getting that sorted. 

Johan
