Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24491726926
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjFGSrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjFGSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CEE1BD0;
        Wed,  7 Jun 2023 11:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062C863A8D;
        Wed,  7 Jun 2023 18:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C80C433EF;
        Wed,  7 Jun 2023 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686163652;
        bh=vckK3sx99kosm5tbvIBaok8NvWyioD245qpFlAjyDA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1RC6AzKNy3Zfj98kfUZbqPI7XhChLNep8jfMn46y5w3aKM11t5F9BH6H+/YkuihA
         gry98AmB5xePHGueftzkGdLapKM8zath5y6zsq+xhS5K20gNKz6KXHuRuunfSwoGXD
         kTpVrjashEQRrnSn3FvO0qWWIqCtUfLcvS8Q+NEc=
Date:   Wed, 7 Jun 2023 20:47:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v1 0/2] Privileged process support on remote
 subsystem
Message-ID: <2023060722-zap-fiftieth-4323@gregkh>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:00:05PM +0530, Ekansh Gupta wrote:
> Add support to run remote user process as privileged on remote
> subsystem. The privileged user process can be given prioritized
> access to remote processor resources. This is achieved in kernel
> based on the group ID of the process. The kernel will have a
> pre-defined fastrpc group ID and if the process's group ID matches
> with it, then the process is treated as a privileged process. This
> information is sent to the remote processor during PD initialization
> and the PD is treated as a privileged PD.
> 
> Ekansh Gupta (2):
>   dt-bindings: misc: fastrpc: add fastrpc group IDs property
>   misc: fastrpc: detect privileged processes based on group ID
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   6 +
>  drivers/misc/fastrpc.c                             | 124 +++++++++++++++++++++
>  2 files changed, 130 insertions(+)
> 
> -- 
> 2.7.4
> 

Why is this a RESEND?

thanks,

greg k-h
