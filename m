Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5796A6E09D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDMJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDMJL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30C2A246;
        Thu, 13 Apr 2023 02:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3278963CCA;
        Thu, 13 Apr 2023 09:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87665C433EF;
        Thu, 13 Apr 2023 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681377065;
        bh=KJ+kj012Wj4+JPMEPeJ8SLU0S5tXuwOlfCXwCdq6UN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=It6P+LX0bqjZaqIQAtE/xtTLGynXjpb7STQZ29f1Qq0AzB30Da3VIiWUJq3QADs6K
         HwbweYQa6ENNgRjfWfet8bRK2cQIHCwueGBuVVhX2lSS+ytLGa2hjbG+dZaWS+28nV
         gEZx81BoBTtJSFzRDgTYBG820P+c9p3XNvLXkV/TaeujA9coGObSSJ9O23MJfoQmnt
         8qQeBIBFu8CCvQWIf0XmBySQvGIAv3SuL/QgKFdi78K7tF8jutu3g2DVv34ol7u1Ia
         YIG4SssqUbf+6rlQt57KTT5N4swtRChCuQ4Z1Q8iqbpDvlgQevemhQXR//4KKUiK8J
         gXip89WJeCZQA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmsyx-0000EE-O4; Thu, 13 Apr 2023 11:11:08 +0200
Date:   Thu, 13 Apr 2023 11:11:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin
 drive-strength
Message-ID: <ZDfHK2pfHtq5hgfD@hovoldconsulting.com>
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
 <ZDVtXkCON8DFUDjh@hovoldconsulting.com>
 <887eb9f6-9882-37c6-4332-ddae7a354187@linaro.org>
 <ZDZUiW+74rhhRAfS@hovoldconsulting.com>
 <15e1d05f-b7e1-27bc-7363-aefd2d155eea@linaro.org>
 <ZDZbif25qQh79cuG@hovoldconsulting.com>
 <a84b11c7-c49d-6859-cdd7-16b4d37489df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84b11c7-c49d-6859-cdd7-16b4d37489df@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:53:07AM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2023 09:19, Johan Hovold wrote:

> > The general suggestion is still to check 'git log --oneline' for the
> > files in question and use what appears to be the (recent) common prefix.
> 
> I do it for subsystems, but I am not going to do it per file. Sorry, I
> am sending way too many of them to keep also customizing them per each
> file.

Perhaps you should start grouping your patch bombs of identical changes
rather than send them per file if this is such a burden.

Either way, that is no excuse when changing a single file.

> If you wanted x13s prefix, then you would name the file like that.
> If you named file differently, then apparently that's how you want it to
> look.

No, that is not what we want. The git log tells you what we expect. And
the x13s prefix is there, you just randomly decided to drop it.

Johan
