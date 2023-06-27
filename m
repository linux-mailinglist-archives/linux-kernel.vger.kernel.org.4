Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D273FB12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjF0LYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjF0LYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA1296A;
        Tue, 27 Jun 2023 04:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1512B61117;
        Tue, 27 Jun 2023 11:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEE4C433C8;
        Tue, 27 Jun 2023 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687865045;
        bh=Prlun11rJOIMAzsv1OBlBmCoq1zgUp9+r/ZIMTOKY4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V45ksJpqjZewQHVmCGcAUd+vhJY5qFsxz6FWOLQ8AmUJpquRUzn0ccql3n6PMLIhI
         XuH1VLXZMa6IPbUtcmNrwpSQybIwYNIf9l87lDhvU7EqRvrHK3VRedAiS6VktOk+iu
         VEBJ4sRnvkM7asOtjvG0Z59KApOjkZmJQitohIWrmklKn8djgPojZAeYduZf0unrCR
         FRmC4bsADE80C2A6f0eGESOu3/fqFXubynE2L7S+TakEpKbRZzXorqO3+0urtRUiK4
         R+HigFSjV4ZbFtjuTzwIIgYi5nEegre5kqxMTXBfW/Hs1pykA2jzrd6mRSoN2IA71e
         Au/tVfiIuengQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qE6ni-0002EP-OU; Tue, 27 Jun 2023 13:24:02 +0200
Date:   Tue, 27 Jun 2023 13:24:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v9 02/10] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <ZJrG0kScA3sHw4l9@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:06:20AM +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Snps Dwc3 controller.

Please spell out "Synopsis" and use consistent capitalisation for dwc3
(i.e. "dwc3" or "DWC3").

Johan
