Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35873B83A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjFWMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFWMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:53:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26465271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:52:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-311183ef595so643618f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524753; x=1690116753;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E608wQQ3NuR5N+ldihF+0RecIdJUPrb2WsqabYtDHvk=;
        b=PY+7C3++RTxYyAAUzqw3iUpPOVwbwp4jskWG2DCqWonjXOMSibVhGJlTHGNOHUGUkd
         YhzqNkjSw9+rSEpg7C012r7TbxvpzrQfDwHF+oI9Yf9CdeAba3Ks/xBr12zMTKCmn+74
         kqBPAlCIisEvS0BgBFZeyx0vk/7WomsCvjfboi5iFoLKQvYEBKqdC/GBalp2hKWxw88G
         FyZo9EGL7eHmmBva593ljWU2rjY6eo9ndOzl1fu7jUsGkUKwLcKQpx7dUFbJ35/34UZF
         SIaGb9/IIAkAan8hYQ2ndKEd41ETK4J+1bufsxHL2LK+jBz4K8Y7wWWqdHBpd0vDIoRg
         0A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524753; x=1690116753;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E608wQQ3NuR5N+ldihF+0RecIdJUPrb2WsqabYtDHvk=;
        b=g7wDnHwbK3W3HNi3RsXjjtK20GnMroq5qKqx5F93Co4XOKUHOicoxNmHw0NyomuqQQ
         hW3T6z6/0QXjY6KngczYaYwqD4iOoFra4KWv56JbLkfV6LSay+9WzBPMwb/GE0/4ufpk
         pWRHHEz0NtqmOEyAkn8FvegjiPtu0BtY4VjNY98Ugd2JOW6qalAbKoSWhXBQppDhOx0o
         b11f1pT5n9qalzU1+1iXqGtoEKIWma9vBuoqmGRa6CXGt60efFBy+aTTsLpqjQxUyclI
         xj1FxLvtGTxgbc0zu2Ep8te7BXh5DzBqaxHPnI3HASRtsraav3tA5iAnzypg67prUC95
         1Q+Q==
X-Gm-Message-State: AC+VfDyx+HW6OUtkSgxsTgJMuNlpaDys9kWlM9c+rPa6ALZSz8S4MWyZ
        QrLVmG6SB3sdYw3gD6JFDlUzuQ==
X-Google-Smtp-Source: ACHHUZ5hI0uNaFZGooNoKoHdqHFOV87aKEgGlpwpoD7zhafRG/kt0kvIfA5VFxpRcpjwCLNvl9uMSA==
X-Received: by 2002:adf:db47:0:b0:311:1a6f:289e with SMTP id f7-20020adfdb47000000b003111a6f289emr17381361wrj.25.1687524752711;
        Fri, 23 Jun 2023 05:52:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad0e:ec08:3cf4:d907? ([2a01:e0a:982:cbb0:ad0e:ec08:3cf4:d907])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b0030647449730sm9623996wrq.74.2023.06.23.05.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:52:32 -0700 (PDT)
Message-ID: <fb00719f-26f2-38d0-b91e-7a49e94f52b8@linaro.org>
Date:   Fri, 23 Jun 2023 14:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] bluetooth: qca: add support for WCN7850
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
 <20230620-topic-sm8550-upstream-bt-v1-2-4728564f8872@linaro.org>
 <b56bdd22-7d68-8a48-4207-ca6b83ec2644@linaro.org>
 <CABBYNZ+JRbvOKnup0dH8V7YBpYcGuSn00i7zPhKP=3M3rEfF7Q@mail.gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <CABBYNZ+JRbvOKnup0dH8V7YBpYcGuSn00i7zPhKP=3M3rEfF7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On 22/06/2023 21:54, Luiz Augusto von Dentz wrote:
> Hi Neil
> 
> On Tue, Jun 20, 2023 at 8:43 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 20.06.2023 17:19, Neil Armstrong wrote:
>>> Add support for the WCN7850 Bluetooth chipset.
>>>
>>> Tested on the SM8550 QRD platform.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>> I don't have comments for this patch specifically, but:
>>
>>
>>>   drivers/bluetooth/btqca.c   |  7 +++++++
>>>   drivers/bluetooth/btqca.h   | 10 ++++++++++
>>>   drivers/bluetooth/hci_qca.c | 48 ++++++++++++++++++++++++++++++++++-----------
>>>   3 files changed, 54 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>> index e7e58a956d15..037146b476ff 100644
>>> --- a/drivers/bluetooth/btqca.c
>>> +++ b/drivers/bluetooth/btqca.c
>>> @@ -617,6 +617,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>        } else if (soc_type == QCA_WCN6855) {
>>>                snprintf(config.fwname, sizeof(config.fwname),
>>>                         "qca/hpbtfw%02x.tlv", rom_ver);
>>> +     } else if (soc_type == QCA_WCN7850) {
>>> +             snprintf(config.fwname, sizeof(config.fwname),
>>> +                      "qca/hmtbtfw%02x.tlv", rom_ver);
>>>        } else {
>>>                snprintf(config.fwname, sizeof(config.fwname),
>>>                         "qca/rampatch_%08x.bin", soc_ver);
>>> @@ -654,6 +657,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>        else if (soc_type == QCA_WCN6855)
>>>                snprintf(config.fwname, sizeof(config.fwname),
>>>                         "qca/hpnv%02x.bin", rom_ver);
>>> +     else if (soc_type == QCA_WCN7850)
>>> +             snprintf(config.fwname, sizeof(config.fwname),
>>> +                      "qca/hmtnv%02x.bin", rom_ver);
>>>        else
>>>                snprintf(config.fwname, sizeof(config.fwname),
>>>                         "qca/nvm_%08x.bin", soc_ver);
>> The above changes should probably be made switch statements as well
>>
>>> @@ -695,6 +701,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>        case QCA_WCN3991:
>>>        case QCA_WCN6750:
>>>        case QCA_WCN6855:
>>> +     case QCA_WCN7850:
>>>                /* get fw build info */
>>>                err = qca_read_fw_build_info(hdev);
>>>                if (err < 0)
>>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>>> index b884095bcd9d..ff1850e984fe 100644
>>> --- a/drivers/bluetooth/btqca.h
>>> +++ b/drivers/bluetooth/btqca.h
>>> @@ -148,6 +148,7 @@ enum qca_btsoc_type {
>>>        QCA_QCA6390,
>>>        QCA_WCN6750,
>>>        QCA_WCN6855,
>>> +     QCA_WCN7850,
>>>   };
>>>
>>>   #if IS_ENABLED(CONFIG_BT_QCA)
>>> @@ -173,6 +174,10 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
>>>   {
>>>        return soc_type == QCA_WCN6855;
>>>   }
>>> +static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
>>> +{
>>> +     return soc_type == QCA_WCN7850;
>>> +}
>>>
>>>   #else
>>>
>>> @@ -216,6 +221,11 @@ static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
>>>        return false;
>>>   }
>>>
>>> +static inline bool qca_is_wcn7850(enum qca_btsoc_type soc_type)
>>> +{
>>> +     return false;
>>> +}
>>> +
>>>   static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>>>   {
>>>        return -EOPNOTSUPP;
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index e30c979535b1..49b8d75d271e 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1322,7 +1322,8 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>>>        /* Give the controller time to process the request */
>>>        if (qca_is_wcn399x(qca_soc_type(hu)) ||
>>>            qca_is_wcn6750(qca_soc_type(hu)) ||
>>> -         qca_is_wcn6855(qca_soc_type(hu)))
>>> +         qca_is_wcn6855(qca_soc_type(hu)) ||
>>> +         qca_is_wcn7850(qca_soc_type(hu)))
>>>                usleep_range(1000, 10000);
>> Separate topic, but I see usages of the helper and raw comparisons
>> everywhere.. I'd vote for switch everywhere
> 
> +1, most of the time it is preferable to go with switches which makes
> the code cleaner/more readable, Im fine not requiring it in this set
> but I hope someone looks into doing some cleanup in this code.

Since we have time until the end of the v6.5 merge window I'll add an intermediate
change adding switch/case for v2.

Thanks,
Neil

> 
>> Konrad
>>>        else
>>>                msleep(300);
>>> @@ -1400,7 +1401,8 @@ static int qca_check_speeds(struct hci_uart *hu)
>>>   {
>>>        if (qca_is_wcn399x(qca_soc_type(hu)) ||
>>>            qca_is_wcn6750(qca_soc_type(hu)) ||
>>> -         qca_is_wcn6855(qca_soc_type(hu))) {
>>> +         qca_is_wcn6855(qca_soc_type(hu)) ||
>>> +         qca_is_wcn7850(qca_soc_type(hu))) {
>>>                if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>>>                    !qca_get_speed(hu, QCA_OPER_SPEED))
>>>                        return -EINVAL;
>>> @@ -1435,7 +1437,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>>                 */
>>>                if (qca_is_wcn399x(soc_type) ||
>>>                    qca_is_wcn6750(soc_type) ||
>>> -                 qca_is_wcn6855(soc_type))
>>> +                 qca_is_wcn6855(soc_type) ||
>>> +                 qca_is_wcn7850(soc_type))
>>>                        hci_uart_set_flow_control(hu, true);
>>>
>>>                if (soc_type == QCA_WCN3990) {
>>> @@ -1454,7 +1457,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>>   error:
>>>                if (qca_is_wcn399x(soc_type) ||
>>>                    qca_is_wcn6750(soc_type) ||
>>> -                 qca_is_wcn6855(soc_type))
>>> +                 qca_is_wcn6855(soc_type) ||
>>> +                 qca_is_wcn7850(soc_type))
>>>                        hci_uart_set_flow_control(hu, false);
>>>
>>>                if (soc_type == QCA_WCN3990) {
>>> @@ -1691,7 +1695,8 @@ static int qca_power_on(struct hci_dev *hdev)
>>>
>>>        if (qca_is_wcn399x(soc_type) ||
>>>            qca_is_wcn6750(soc_type) ||
>>> -         qca_is_wcn6855(soc_type)) {
>>> +         qca_is_wcn6855(soc_type) ||
>>> +         qca_is_wcn7850(soc_type)) {
>>>                ret = qca_regulator_init(hu);
>>>        } else {
>>>                qcadev = serdev_device_get_drvdata(hu->serdev);
>>> @@ -1733,7 +1738,8 @@ static int qca_setup(struct hci_uart *hu)
>>>        bt_dev_info(hdev, "setting up %s",
>>>                qca_is_wcn399x(soc_type) ? "wcn399x" :
>>>                (soc_type == QCA_WCN6750) ? "wcn6750" :
>>> -             (soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
>>> +             (soc_type == QCA_WCN6855) ? "wcn6855" :
>>> +             (soc_type == QCA_WCN7850) ? "wcn7850" : "ROME/QCA6390");
>>>
>>>        qca->memdump_state = QCA_MEMDUMP_IDLE;
>>>
>>> @@ -1746,7 +1752,8 @@ static int qca_setup(struct hci_uart *hu)
>>>
>>>        if (qca_is_wcn399x(soc_type) ||
>>>            qca_is_wcn6750(soc_type) ||
>>> -         qca_is_wcn6855(soc_type)) {
>>> +         qca_is_wcn6855(soc_type) ||
>>> +         qca_is_wcn7850(soc_type)) {
>>>                set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>>                hci_set_aosp_capable(hdev);
>>>
>>> @@ -1769,7 +1776,8 @@ static int qca_setup(struct hci_uart *hu)
>>>
>>>        if (!(qca_is_wcn399x(soc_type) ||
>>>              qca_is_wcn6750(soc_type) ||
>>> -           qca_is_wcn6855(soc_type))) {
>>> +           qca_is_wcn6855(soc_type) ||
>>> +           qca_is_wcn7850(soc_type))) {
>>>                /* Get QCA version information */
>>>                ret = qca_read_soc_version(hdev, &ver, soc_type);
>>>                if (ret)
>>> @@ -1909,6 +1917,20 @@ static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
>>>        .capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
>>>   };
>>>
>>> +static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
>>> +     .soc_type = QCA_WCN7850,
>>> +     .vregs = (struct qca_vreg []) {
>>> +             { "vddio", 5000 },
>>> +             { "vddaon", 26000 },
>>> +             { "vdddig", 126000 },
>>> +             { "vddrfa0p8", 102000 },
>>> +             { "vddrfa1p2", 257000 },
>>> +             { "vddrfa1p9", 302000 },
>>> +     },
>>> +     .num_vregs = 6,
>>> +     .capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
>>> +};
>>> +
>>>   static void qca_power_shutdown(struct hci_uart *hu)
>>>   {
>>>        struct qca_serdev *qcadev;
>>> @@ -2074,7 +2096,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>        if (data &&
>>>            (qca_is_wcn399x(data->soc_type) ||
>>>             qca_is_wcn6750(data->soc_type) ||
>>> -          qca_is_wcn6855(data->soc_type))) {
>>> +          qca_is_wcn6855(data->soc_type) ||
>>> +          qca_is_wcn7850(data->soc_type))) {
>>>                qcadev->btsoc_type = data->soc_type;
>>>                qcadev->bt_power = devm_kzalloc(&serdev->dev,
>>>                                                sizeof(struct qca_power),
>>> @@ -2105,7 +2128,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>                                               GPIOD_IN);
>>>                if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
>>>                    (data->soc_type == QCA_WCN6750 ||
>>> -                  data->soc_type == QCA_WCN6855))
>>> +                  data->soc_type == QCA_WCN6855 ||
>>> +                  data->soc_type == QCA_WCN7850))
>>>                        dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>>>
>>>                qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>> @@ -2182,7 +2206,8 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>>>
>>>        if ((qca_is_wcn399x(qcadev->btsoc_type) ||
>>>             qca_is_wcn6750(qcadev->btsoc_type) ||
>>> -          qca_is_wcn6855(qcadev->btsoc_type)) &&
>>> +          qca_is_wcn6855(qcadev->btsoc_type) ||
>>> +          qca_is_wcn7850(qcadev->btsoc_type)) &&
>>>            power->vregs_on)
>>>                qca_power_shutdown(&qcadev->serdev_hu);
>>>        else if (qcadev->susclk)
>>> @@ -2368,6 +2393,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>>>        { .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>>>        { .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>>>        { .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
>>> +     { .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
>>>        { /* sentinel */ }
>>>   };
>>>   MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>>>
> 
> 
> 

