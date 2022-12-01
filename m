Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05F63E95F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLAFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLAFiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:38:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECF578D1;
        Wed, 30 Nov 2022 21:38:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7049CB81DEC;
        Thu,  1 Dec 2022 05:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24F5C433D6;
        Thu,  1 Dec 2022 05:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669873098;
        bh=2h7CoLZeC0jMFm3rbqtN3ZLizkHMihcs4KBM1Gmnfgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8BAhJnFnlzeFz3P5NpxP3U/qkGQl/h6rQ/5N3Yuocrv8hToVczjVMGxLcLHgraMm
         rH37/zq2EUAB5syIuWN9O9f07XEdFrpyAtsqTVl6Bu3q+xMfswQojZznlEvJQxJOZQ
         TeF0HBh3rYoJOE1ZkMoeCvp1PdDpoeKt82kdTy8IQdkd5PrlFYkObSj3W7+1G+Qrmz
         WZ4hv8S36ciehyJobCp5DYOTVE2jPnpGTIB6fIytG65rIT2lA1VARcJEz0APVknVPF
         fh51AeXhYjZB1RM+250nbjw8CR8CS2544yyRszAfIhr+BRQEbOGHcq3ubY7lJrYuRv
         14fxyWs+P8B2Q==
Date:   Thu, 1 Dec 2022 13:38:13 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: mfd: Add compatible string for UART
 support
Message-ID: <Y4g9xXP+LXG6zcqy@google.com>
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221130131245.v8.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130131245.v8.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:12:55PM -0700, Mark Hasemeyer wrote:
> Add a compatible string to support the UART implementation of the cros
> ec interface.

$ git am ...
...
Applying: dt-bindings: mfd: Add compatible string for UART support
error: patch failed: Documentation/devicetree/bindings/mfd/google,cros-ec.yaml:28
error: Documentation/devicetree/bindings/mfd/google,cros-ec.yaml: patch does not apply
Patch failed at 0002 dt-bindings: mfd: Add compatible string for UART support

Please use either for-next branch or linux-next as base.  There are DT binding
changes in the queue for 6.2.
- 7a2f36828c7b ("dt-bindings: cros-ec: Reorganize and enforce property
		 availability")
- e068bc0b01cf ("dt-bindings: cros-ec: Add ChromeOS fingerprint binding")
