Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88C76C9F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjC0JNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjC0JNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:13:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561D1BD3;
        Mon, 27 Mar 2023 02:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7C761151;
        Mon, 27 Mar 2023 09:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98696C433D2;
        Mon, 27 Mar 2023 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679908393;
        bh=i2DixOICfTfUPwZLMVJoKRB8PiwZdHjvi1UBGoZXtjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aE+TZGdKB+QTUlhkYnSe5/ij+7cpn3cOYgImMe+fvgtL5gv02Mtjdje2CHFXX7BBk
         RxwjoHfbYNos1c3FeezzhWjbXBDbZkDUjKLUoJ7XC4R2xqwb3SoKrOonLoGOOapzNi
         s3JL0ESeq9HuqGi8H7RS4kIJbiQ1h0dBnIpH5NNk=
Date:   Mon, 27 Mar 2023 11:13:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
Message-ID: <ZCFeJkkpIor5P28r@kroah.com>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-4-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324061608.33609-4-quic_hazha@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:16:08PM +0800, Hao Zhang wrote:
> Add documentation for Coresight Dummy Trace under trace/coresight.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../trace/coresight/coresight-dummy.rst       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
> 
> diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
> new file mode 100644
> index 000000000000..819cabab8623
> --- /dev/null
> +++ b/Documentation/trace/coresight/coresight-dummy.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================
> +Coresight Dummy Trace Module
> +=============================
> +
> +    :Author:   Hao Zhang <quic_hazha@quicinc.com>
> +    :Date:     March 2023
> +
> +Introduction
> +---------------------------
> +
> +Coresight Dummy Trace Module is for the specific devices that HLOS don't
> +have permission to access or configure. Such as Coresight sink EUD, some
> +TPDMs etc. So there need driver to register dummy devices as Coresight
> +devices. Provide Coresight API for dummy device operations, such as
> +enabling and disabling dummy devices. Build the Coresight path for dummy
> +sink or dummy source for debugging.
> +
> +Sysfs files and directories
> +---------------------------
> +
> +Root: ``/sys/bus/coresight/devices/dummy<N>``

sysfs files are documented in Documentation/ABI/ not in random .rst
files, sorry.  Please use the correct format described there, not a
random one like this :)

thanks,

greg k-h
