Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9143B6B8DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCNIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCNIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:54:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD8C5D444
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:54:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m35so133060wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678784053;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v75KTMuw3KcdDlrLuoPJiGsmVBznB/RJnpqv1/ly5lI=;
        b=aNjUjLrcpaXjwu/4dbQzHaY4b3Dn3tv81YXVqdiqApk5IEp9oECS4JWIDTNUVppAym
         y9L7MeJazA4s4euFcL/Y5gSA7r/P00+tXhJhCnkoEqXRKOp1+JYNMppKKi863Fpetisj
         W71QhvISwvBCfbprWr3tOQL7TGpENcbYc20v7IGGwBE9LLp1raxERYAojlFUxC0ESJ+q
         8aE/QNqBrbCaIRrd47RcCnBRnbJV3YsxWJi0kuiPG2mmyhtYmRGOhTf2Q6ewrdsUk7f+
         WzMIEOpjdjbEGoM79qboDF8TTvNBGiDqLFAXsqARGz+ZSY8jVTCAqE8iUvj+1xh2U+40
         s3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678784053;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v75KTMuw3KcdDlrLuoPJiGsmVBznB/RJnpqv1/ly5lI=;
        b=EZQ6caF4Qpli+bIOSJoMECHe0U052zThzDV0VLanY+8YBBDZw0J4EoRLLb0BcYtNZX
         wJ8ertOcsU087FE02Wlqo+6tf9DcsH0qz+cWlLpw9gyl5gBUPM2/1zmyFC9NeA9cM/gp
         B53+IP8YaXHbLOxsHVemwBxv/v1upmyuUFUucw/npCWThE3Y/qh2Hr0Go3O8Ol463tW3
         rPIaC63/+ZCrJGUhIvnLVhq8sy0Kul8duoOcGhVUUSikYg7xNz5PDwHq5XzXoisjmQdK
         2+ef1sgApSvN0bkdVBxAs/wyOHcR+tl6mjuf2UzZ1Nk42kWmjTcGufzgPYl3I9IH30zB
         ZIZg==
X-Gm-Message-State: AO0yUKVszvOktPhkaXO+96Db58Rsy41g2qoxmiYwTJO7YIM/7s3I3DXs
        LpGF6Bt3d0J1rkrHckZu/gzNnQ==
X-Google-Smtp-Source: AK7set+WZGtNLvW0dZC4TbyqElBmfwd/9FmjaR6AfzRA4EVNJIBui7DLWbnR0qrXHxzQSr5KwXGxCw==
X-Received: by 2002:a05:600c:4f08:b0:3e2:20c7:6544 with SMTP id l8-20020a05600c4f0800b003e220c76544mr13392562wmq.19.1678784053087;
        Tue, 14 Mar 2023 01:54:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11c3:d4e5:ef75:8eb9? ([2a01:e0a:982:cbb0:11c3:d4e5:ef75:8eb9])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c440f00b003dfe549da4fsm2142551wmn.18.2023.03.14.01.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:54:12 -0700 (PDT)
Message-ID: <d7bd6663-516a-a1f9-506c-5853eaa948e4@linaro.org>
Date:   Tue, 14 Mar 2023 09:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 01/12] usb: typec: ucsi: add PMIC Glink UCSI driver
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v3-1-4c860d265d28@linaro.org>
 <ZA7wPtttsWlQRpAR@kuha.fi.intel.com>
Organization: Linaro Developer Services
In-Reply-To: <ZA7wPtttsWlQRpAR@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 10:43, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, Mar 09, 2023 at 02:27:52PM +0100, Neil Armstrong wrote:
>> +static void pmic_glink_ucsi_register(struct work_struct *work)
>> +{
>> +	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
>> +
>> +	ucsi_register(ucsi->ucsi);
>> +}
>> +
>> +static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
>> +{
>> +	struct pmic_glink_ucsi *ucsi = priv;
>> +	const struct pmic_glink_hdr *hdr = data;
>> +
>> +	switch (hdr->opcode) {
>> +	case UC_UCSI_READ_BUF_REQ:
>> +		pmic_glink_ucsi_read_ack(ucsi, data, len);
>> +		break;
>> +	case UC_UCSI_WRITE_BUF_REQ:
>> +		pmic_glink_ucsi_write_ack(ucsi, data, len);
>> +		break;
>> +	case UC_UCSI_USBC_NOTIFY_IND:
>> +		schedule_work(&ucsi->notify_work);
>> +		break;
>> +	};
>> +}
>> +
>> +static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
>> +{
>> +	struct pmic_glink_ucsi *ucsi = priv;
>> +
>> +	if (state == SERVREG_SERVICE_STATE_UP)
>> +		schedule_work(&ucsi->register_work);
>> +	else if (state == SERVREG_SERVICE_STATE_DOWN)
>> +		ucsi_unregister(ucsi->ucsi);
>> +}
>> +
>> +static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>> +				 const struct auxiliary_device_id *id)
>> +{
>> +	struct pmic_glink_ucsi *ucsi;
>> +	struct device *dev = &adev->dev;
>> +
>> +	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
>> +	if (!ucsi)
>> +		return -ENOMEM;
>> +
>> +	ucsi->dev = dev;
>> +	dev_set_drvdata(dev, ucsi);
>> +
>> +	INIT_WORK(&ucsi->notify_work, pmic_glink_ucsi_notify);
>> +	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
>> +	init_completion(&ucsi->read_ack);
>> +	init_completion(&ucsi->write_ack);
>> +	init_completion(&ucsi->sync_ack);
>> +	mutex_init(&ucsi->lock);
>> +
>> +	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
>> +	if (IS_ERR(ucsi->ucsi))
>> +		return PTR_ERR(ucsi->ucsi);
>> +
>> +	ucsi_set_drvdata(ucsi->ucsi, ucsi);
>> +
>> +	ucsi->client = devm_pmic_glink_register_client(dev,
>> +						       PMIC_GLINK_OWNER_USBC,
>> +						       pmic_glink_ucsi_callback,
>> +						       pmic_glink_ucsi_pdr_notify,
>> +						       ucsi);
>> +	return PTR_ERR_OR_ZERO(ucsi->client);
>> +}
>> +
>> +static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {
>> +	{ .name = "pmic_glink.ucsi", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, pmic_glink_ucsi_id_table);
>> +
>> +static struct auxiliary_driver pmic_glink_ucsi_driver = {
>> +	.name = "pmic_glink_ucsi",
>> +	.probe = pmic_glink_ucsi_probe,
>> +	.id_table = pmic_glink_ucsi_id_table,
>> +};
> 
> What happens if you remove the module - I think you need to implement
> the remove callback, no?

You're right, I thought devm_pmic_glink_register_client would call
pmic_glink_ucsi_pdr_notify which would unregister ucsi, but no so will add.

Thanks,
Neil

> 
> thanks,
> 

