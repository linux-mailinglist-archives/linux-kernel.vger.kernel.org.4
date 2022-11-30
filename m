Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2E63DF27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiK3Soa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiK3SoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:44:05 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC10F98962;
        Wed, 30 Nov 2022 10:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669833842; x=1701369842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Gtyz6SNZuGgTDy//usOG/QH31joaiy/IY6bcuWc0RzI=;
  b=TI6t8gdPKYOnDxR71LS0W+ybg8yfq5nniGdwWUrp/rcnLnhJoGRnK6Z4
   WvrjoX0AVzQtSICJpQsujFz83pWFJW4c8B0l9ZI0hOKf8z9XE6r04q4KH
   vBtvAzLTKvtAOsQb1FubkJPgog12azvfRMoQnVdGFfXitpy9afsg+rQNa
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2022 10:44:02 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 10:44:02 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 10:44:01 -0800
Date:   Wed, 30 Nov 2022 10:44:01 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Eddie Huang =?utf-8?B?KOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>
CC:     "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        Stanley Chu =?utf-8?B?KOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH v7 06/16] ufs: core: mcq: Configure resource regions
Message-ID: <20221130184401.GB9934@asutoshd-linux1.qualcomm.com>
References: <cover.1669747235.git.quic_asutoshd@quicinc.com>
 <c655d1e62f619818e034f76c90330393cba8c79b.1669747235.git.quic_asutoshd@quicinc.com>
 <37a017a2176fee1da8a7903613f132b22c9741df.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37a017a2176fee1da8a7903613f132b22c9741df.camel@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30 2022 at 01:15 -0800, Eddie Huang (黃智傑) wrote:
>Hi Asutosh,
>
>On Tue, 2022-11-29 at 10:53 -0800, Asutosh Das wrote:
>Please correct:
>
>return hba->vops->mcq_config_resource(hba);
>
Thanks, I missed correcting it before pushing it up.
I will send a next version now.

-asd

>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>
>
>Except this issue, I test this series pass on my platform. Thanks the
>patch
>
>Eddie
>
