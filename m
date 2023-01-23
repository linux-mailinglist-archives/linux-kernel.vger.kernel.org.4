Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C97677D93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjAWOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjAWOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF14C21;
        Mon, 23 Jan 2023 06:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21FB1B80DCA;
        Mon, 23 Jan 2023 14:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EF4C4339B;
        Mon, 23 Jan 2023 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674482771;
        bh=b4799f3ambcaidRH6yMkeHs72IrDKn2G8XQwYPBreSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BALzoVSm+ibMV50GLb9YIsysU8sMD7eVqCKeQbCArzCC5BG0ss945pYpuzrmqkqpD
         fkwoYOsH4Y+2IE3MC/cVSV0zqPqcBsF8HVnTliXy22KodKSTzOQR0EJovo+dUlQ5k1
         M6JvHsFR+VOm3bjzN/wXbaNz/sb4TueOSYewAnAoKpZbZs/Njs1epjX29woVMKglQ3
         P6rxe0jO2iBxctZ2VW85DPlMMT3GOaoobBzO8XnnOp6YIw2jLaJpkeLJZmyqiQy7cu
         76AcKCZi01DqJAbHfCsy5UzMCVgplLh+TnMmnd1ydSWeBYdXmB2XpDagKDCAprDLQ7
         VtFYzjK5oThdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJxSb-0003TK-At; Mon, 23 Jan 2023 15:06:09 +0100
Date:   Mon, 23 Jan 2023 15:06:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y86UUWn027zOgOxg@hovoldconsulting.com>
References: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
 <20230120-sm6350-usbphy-v4-2-4d700a90ba16@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120-sm6350-usbphy-v4-2-4d700a90ba16@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 02:29:50PM +0100, Luca Weiss wrote:
> Add the tables and config for the combo phy found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
