Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B96A4AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjB0TdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB0TdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:33:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CAC9033;
        Mon, 27 Feb 2023 11:33:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2EC5B80BAA;
        Mon, 27 Feb 2023 19:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94263C433EF;
        Mon, 27 Feb 2023 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677526380;
        bh=tD3AeHrLgU89owJCVTQQS+07OI5+csQxxiYLD8AN3Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=om9MfLpxOS9Ov+xk+Mo9BtZGQ5BZsmxgYSgLnE5dfgvHC7yx4GrL5+NRKd9MaaZ+c
         m5uAzQkTw5HfDeZ+Dybzbv2FnAfaOvTEIvzwBhZ3bIggg6GvUc91eJGDF/uHxrnCan
         xPs8EIj6wl0AoILJgyGb3kE4dqwR2BfrV3p6/haxErqCRM4z6knAkYP2tGw8DHT9QM
         cyG+v2vjKsqZtcNXmL2Q3qlYJIygDRLrDt3FI4wUX3B01Z77DaFskTI6I81+yFam8U
         01Ddg8LaAhf8/fmpChjEmqReqYcfXk1fhIg11QiwfBdI2zc6swNB7+MvrYS8zvlQvG
         KQQjsTStIUeLg==
Date:   Mon, 27 Feb 2023 11:36:20 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] Add trace events for remoteproc
Message-ID: <20230227193620.hzrlt3e5vh5xz74v@ripper>
References: <20230224165142.17745-1-quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224165142.17745-1-quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 08:51:41AM -0800, Gokul krishna Krishnakumar wrote:
> This patch attempts to add traces for important remoteproc events,
> this will help in debugging errors with the subsystem restart and
> also helps in getting an estimate on how long each event takes to run.
> 

Please skip sending cover-letters for single patches. Also, this is the
kind of motivation that should be included in the commit message.

Thanks,
Bjorn

> Gokul krishna Krishnakumar (1):
>   remoteproc: qcom: Add remoteproc tracing
> 
>  drivers/remoteproc/Makefile           |  3 ++-
>  drivers/remoteproc/qcom_common.c      | 25 +++++++++++++++++++
>  drivers/remoteproc/qcom_q6v5.c        |  3 +++
>  drivers/remoteproc/qcom_q6v5_pas.c    | 17 +++++++++++++
>  drivers/remoteproc/qcom_sysmon.c      | 13 ++++++++++
>  drivers/remoteproc/qcom_tracepoints.c | 10 ++++++++
>  include/trace/events/rproc_qcom.h     | 36 +++++++++++++++++++++++++++
>  7 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>  create mode 100644 include/trace/events/rproc_qcom.h
> 
> 
> base-commit: 7c855ef7137a67bcff0e039691b969428dd8ef6a
> -- 
> 2.39.2
> 
