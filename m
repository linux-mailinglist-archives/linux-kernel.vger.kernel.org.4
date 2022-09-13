Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7195B76B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiIMQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiIMQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA52BD1CB;
        Tue, 13 Sep 2022 08:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3236148A;
        Tue, 13 Sep 2022 15:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F939C433C1;
        Tue, 13 Sep 2022 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663083561;
        bh=hdzbMLB+OJ8cSYqpFPdtuabfUwCyTVksg9R5H7w1rxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1B1fl67g266hqwu9fyDgpcc5qq+LxmYN+nz3ADp6ysgt/uXn8K+ZiIa7907dCy1p
         gqdsag6VJtsW2qIPJCKxLRAFSnW0CephlAfhYQKbSyyrqsK3r3Yd8yre1yJ+yZiccZ
         uZiejsrrYo1te3jO4kDp7HTFkmvd+s9ouvCSFW1mBHNM2ruXpp8rOKOj6wiEEe0h32
         3AozQ/ZNMofA+h11rH9LLL4iir3sHjzojSNMM3nnSPTCMNqjep5OUiz6x3PVEzeVDx
         R5vzu8XPqwI83WUCxronnovJvaAWY/iYzanVOXTmPVU5ENUUWioQWtHjy85tKrVZwS
         v4lz3nvTIRJaA==
Date:   Tue, 13 Sep 2022 10:39:18 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh@kernel.org, rafael@kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH 1/4] thermal: qcom: qmi_cooling: Add skeletal qmi cooling
 driver
Message-ID: <20220913153918.e2bckss5htpjuuhw@builder.lan>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
 <20220912085049.3517140-2-bhupesh.sharma@linaro.org>
 <ec1858fe-753f-c63a-4580-35851241fbcf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1858fe-753f-c63a-4580-35851241fbcf@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:23:21PM -0700, Jeff Johnson wrote:
> On 9/12/2022 1:50 AM, Bhupesh Sharma wrote:
[..]
> > diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c b/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
[..]
> > +static struct qmi_elem_info tmd_mitigation_dev_id_type_v01_ei[] = {
> 
> note that commit ff6d365898d ("soc: qcom: qmi: use const for struct
> qmi_elem_info") allows QMI message encoding/decoding rules to be const
> 
> <https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=ff6d365898d4d31bd557954c7fc53f38977b491c>
> 
> I'm waiting for that to land in the soc tree before I submit my changes to
> all of the existing drivers, but you can do this now for the new driver
> 

I did merge your patch recently, so you should be able to fetch
linux-next and continue this work:

https://patchwork.kernel.org/project/linux-arm-msm/patch/20220822153435.7856-1-quic_jjohnson@quicinc.com/

Looking forward to the continuation,
Bjorn
