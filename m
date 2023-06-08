Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD47278D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjFHHaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjFHH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:29:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525C1BEB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:29:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c8423dccso294490666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686209394; x=1688801394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7LBmVzSou3ooRsgmzhSqng8ngpcUaRrdsS89j8WENo=;
        b=ArpoyfBFSTuI1FJQ5s/RsG40SpVg73ltXPVk7uvfnxVlY5D/a0UFy2tfQHI2dBe+F/
         +35dHoH6TJL7Yx3PSRHqyDozLblvyOEXp6q+7x82fYPK55AD3+Xh13OdQ/o6aCg82nv8
         UJo4f976c0NHOSfJH6NdVAFtcdaHqg7LkRWOZreymWi/WaJzvLwEkIOfa4A9E2VI8KhD
         m52tIEnzOW4QRYb57k2RiB0RWLDXrJBdVErYbJthBTakVhZhSIODRuYdRz0Hnesb4m/G
         Dgnws9zYOowgOs+GO05vs7JOOWR4YR9fZD9cmJDdK7TeObK/pWDsEF7dO3moPryFk3Lx
         ZigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686209394; x=1688801394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7LBmVzSou3ooRsgmzhSqng8ngpcUaRrdsS89j8WENo=;
        b=b5WWlbx4gNnS9j6mV66MAGr5PI/DoArvWFHzSFgR1rY68AHzRNQdTYKQS19aZhFuE1
         18fRBNLFkoK+5Jy68Q3nQmBMOgyBLtXbnanSU2doNk2N5uhCgfo0Gf9HM+rD5obT4MsE
         NgsKxWI+VF3vutpI5xddbKIT9ht0cYtX9JEGzsIOSHo3mu4XjrMpBP9c0dA80HuJCA1U
         1Dg/+zI6GsxL3WlvNgG8xNHgDkwxw6RovvgcA4APjAGIl2wARNVQ24rMDUwGjMR742yr
         AbThGPFAKaFgooiqTQWInXSX0mBQLfUF9MvjC8poGKZLME7QxJHaNStQ3fAjluy7qiAR
         94mw==
X-Gm-Message-State: AC+VfDytgyku5CRur6WBgCgCZe6JcENIqNuDRD++i8FO39dBFA/UDrKn
        wwDv4xfusnXaksZpfD0ymODxO5nF7v8MRzUSARM=
X-Google-Smtp-Source: ACHHUZ4qzF2hO3OUr64rhyQl8jgmhTqXqnpgiyjt490poBQ+0k99ZOG2KGY0ITN0WSIgqC1lSHfBrA==
X-Received: by 2002:a17:907:1c14:b0:96f:94f1:b0a5 with SMTP id nc20-20020a1709071c1400b0096f94f1b0a5mr1519974ejc.8.1686208896004;
        Thu, 08 Jun 2023 00:21:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906241000b00978886c7cdbsm305528eja.183.2023.06.08.00.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:21:35 -0700 (PDT)
Message-ID: <b343df1a-dbd8-919d-5bea-36d532ec4103@linaro.org>
Date:   Thu, 8 Jun 2023 09:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 3.0 PHY
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-3-stanley_chang@realtek.com>
 <a9a2f3d0-9580-f027-8ec3-ac6e6bed5ed6@linaro.org>
 <0ac12a13a91d41f0ab3a58b435ccb17a@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0ac12a13a91d41f0ab3a58b435ccb17a@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 08:59, Stanley Chang[昌育德] wrote:
> Hi Krzysztof,
> 
>>> +static void do_rtk_usb3_phy_toggle(struct rtk_usb_phy *rtk_phy, int i,
>>> +         bool isConnect)
>>> +{
>>> +     struct reg_addr *regAddr;
>>> +     struct phy_data *phy_data;
>>> +     struct phy_parameter *phy_parameter;
>>> +     size_t index;
>>> +
>>> +     regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[i];
>>> +     phy_data = &((struct phy_data *)rtk_phy->phy_data)[i];
>>> +
>>> +     if (!phy_data) {
>>> +             dev_err(rtk_phy->dev, "%s phy_data is NULL!\n",
>>> + __func__);
>>
>> ???
> Sorry, this check is redundant.
> 
>>
>>> +             return;
>>> +     }
>>> +
>>> +     if (!phy_data->do_toggle)
>>> +             return;
>>> +
>>> +     phy_parameter = phy_data->parameter;
>>> +
>>> +     index = PHY_ADDR_MAP_ARRAY_INDEX(PHY_ADDR_0x09);
>>> +
>>> +     if (index < phy_data->size) {
>>> +             u8 addr = (phy_parameter + index)->addr;
>>> +             u16 data = (phy_parameter + index)->data;
>>> +
>>> +             if (addr == 0xFF) {
>>> +                     addr = ARRAY_INDEX_MAP_PHY_ADDR(index);
>>> +                     data = rtk_usb_phy_read(regAddr, addr);
>>> +                     (phy_parameter + index)->addr = addr;
>>> +                     (phy_parameter + index)->data = data;
>>> +             }
>>> +             mdelay(1);
>>> +             dev_info(rtk_phy->dev,
>>> +                         "%s ########## to toggle PHY addr 0x09
>> BIT(9)\n",
>>> +                         __func__);
>>> +             rtk_usb_phy_write(regAddr, addr, data&(~BIT(9)));
>>> +             mdelay(1);
>>> +             rtk_usb_phy_write(regAddr, addr, data);
>>> +     }
>>> +     dev_info(rtk_phy->dev, "%s ########## PHY addr 0x1f = 0x%04x\n",
>>> +                 __func__, rtk_usb_phy_read(regAddr,
>> PHY_ADDR_0x1F));
>>
>> Please drop all simple debug success messages. Linux has already
>> infrastructure for this.
>>
> Okay. I will change the print dev_info to dev_dbg about debug message.

No, drop them. This piece of code had already 2 printks for register
contents! Your driver is overloaded with printks and they are mostly
useless for the user.

> 
>> ...
>>
>>> +     return 0;
>>> +}
>>> +
>>> +static int rtk_usb_phy_init(struct phy *phy) {
>>> +     struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
>>> +     int ret = 0;
>>> +     int i;
>>> +     unsigned long phy_init_time = jiffies;
>>> +
>>> +     if (!rtk_phy) {
>>> +             pr_err("%s rtk_phy is NULL!\n", __func__);
>>
>> What? How is this possible?
> It should be not necessary. I will remove it.
> 
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     dev_dbg(rtk_phy->dev, "Init RTK USB 3.0 PHY\n");
>>> +     for (i = 0; i < rtk_phy->phyN; i++)
>>> +             ret = do_rtk_usb_phy_init(rtk_phy, i);
>>> +
>>> +     dev_info(rtk_phy->dev, "Initialized RTK USB 3.0 PHY (take %dms)\n",
>>> +                 jiffies_to_msecs(jiffies - phy_init_time));
>>
>> Please drop all simple debug success messages. Linux has already
>> infrastructure for this.
> 
> Ok, Thanks.
> 
>>> +     return ret;
>>> +}
>>> +
>>> +static int rtk_usb_phy_exit(struct phy *phy) {
>>> +     struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
>>> +
>>> +     if (!rtk_phy) {
>>> +             pr_err("%s rtk_phy is NULL!\n", __func__);
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     dev_dbg(rtk_phy->dev, "Exit RTK USB 3.0 PHY\n");
>>
>> Please drop all simple debug success messages. Linux has already
>> infrastructure for this.
> 
> Can I keep log for dev_dbg?

Of course not. This was dev_dbg and I commented on this. This is not a
good debug, we do not print anything on function entrance and exit.
ftrace() is for this.

> 
>>> +static void rtk_usb_phy_toggle(struct usb_phy *usb3_phy, bool
>>> +isConnect, int port) {
>>> +     int index = port;
>>> +     struct rtk_usb_phy *rtk_phy = NULL;
>>> +
>>> +     if (usb3_phy != NULL && usb3_phy->dev != NULL)
>>> +             rtk_phy = dev_get_drvdata(usb3_phy->dev);
>>> +
>>> +     if (rtk_phy == NULL) {
>>> +             pr_err("%s ERROR! NO this device\n", __func__);
>>
>> Your error messages are not helping. No need to shout, no need to handle
>> some non-existing cases. If this is real case, you have broken driver. I actually
>> suspect that.
>>
>> How can you interface with a driver where there is no device?
> 
> OK, I know this is not good programming practice, I will improve this question.
> 
>>> +             return;
>>> +     }
>>> +
>>> +     if (index > rtk_phy->phyN) {
>>> +             pr_err("%s %d ERROR! port=%d > phyN=%d\n",
>>> +                         __func__, __LINE__, index, rtk_phy->phyN);
>>> +             return;
>>> +     }
>>> +
>>> +     do_rtk_usb3_phy_toggle(rtk_phy, index, isConnect); }
>>> +
>>> +static int rtk_usb_phy_notify_port_status(struct usb_phy *x, int port,
>>> +         u16 portstatus, u16 portchange) {
>>> +     bool isConnect = false;
>>
>> This is not C++. Don't use camelcase. See Coding style document.
> 
> I will revised for this style.
> 
>>> +
>>> +     pr_debug("%s port=%d portstatus=0x%x portchange=0x%x\n",
>>> +                 __func__, port, (int)portstatus, (int)portchange);
>>> +     if (portstatus & USB_PORT_STAT_CONNECTION)
>>> +             isConnect = true;
>>> +
>>
>> ...
>>
>>> +
>>> +static int rtk_usb3_set_parameter_show(struct seq_file *s, void
>>> +*unused) {
>>> +     struct rtk_usb_phy *rtk_phy = s->private;
>>> +     const struct file *file = s->file;
>>> +     const char *file_name = file_dentry(file)->d_iname;
>>> +     struct dentry *p_dentry = file_dentry(file)->d_parent;
>>> +     const char *phy_dir_name = p_dentry->d_iname;
>>> +     int ret, index;
>>> +     struct phy_data *phy_data = NULL;
>>> +
>>> +     for (index = 0; index < rtk_phy->phyN; index++) {
>>> +             size_t sz = 30;
>>> +             char name[30] = {0};
>>> +
>>> +             snprintf(name, sz, "phy%d", index);
>>> +             if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
>>> +                     phy_data = &((struct phy_data
>> *)rtk_phy->phy_data)[index];
>>> +                     break;
>>> +             }
>>> +     }
>>> +     if (!phy_data) {
>>> +             dev_err(rtk_phy->dev,
>>> +                                 "%s: No phy_data for %s/%s\n",
>>> +                                 __func__, phy_dir_name,
>> file_name);
>>
>> Mess wrapping/indentation. Actually everywhere in the file...
> 
> I will improve this.
> 
>>> +static int rtk_usb3_set_parameter_open(struct inode *inode, struct
>>> +file *file) {
>>> +     return single_open(file, rtk_usb3_set_parameter_show,
>>> +inode->i_private); }
>>> +
>>> +static ssize_t rtk_usb3_set_parameter_write(struct file *file,
>>> +             const char __user *ubuf, size_t count, loff_t *ppos) {
>>> +     const char *file_name = file_dentry(file)->d_iname;
>>> +     struct dentry *p_dentry = file_dentry(file)->d_parent;
>>> +     const char *phy_dir_name = p_dentry->d_iname;
>>> +     struct seq_file         *s = file->private_data;
>>> +     struct rtk_usb_phy              *rtk_phy = s->private;
>>> +     struct reg_addr *regAddr = NULL;
>>> +     struct phy_data *phy_data = NULL;
>>> +     int ret = 0;
>>> +     char buffer[40] = {0};
>>> +     int index;
>>> +
>>> +     if (copy_from_user(&buffer, ubuf,
>>> +                 min_t(size_t, sizeof(buffer) - 1, count)))
>>> +             return -EFAULT;
>>> +
>>> +     for (index = 0; index < rtk_phy->phyN; index++) {
>>> +             size_t sz = 30;
>>> +             char name[30] = {0};
>>> +
>>> +             snprintf(name, sz, "phy%d", index);
>>> +             if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
>>> +                     regAddr = &((struct reg_addr
>> *)rtk_phy->reg_addr)[index];
>>> +                     phy_data = &((struct phy_data
>> *)rtk_phy->phy_data)[index];
>>> +                     break;
>>
>>
>> Where is the ABI documentation for user interface?
> 
> Do debugfs nodes need ABI documentation?
> Is there a reference?
>>
>>> +
>>> +static inline void create_debug_files(struct rtk_usb_phy *rtk_phy) {
>>> +     struct dentry *phy_debug_root = NULL;
>>> +     struct dentry *set_parameter_dir = NULL;
>>> +
>>> +     phy_debug_root = create_phy_debug_root();
>>> +
>>> +     if (!phy_debug_root) {
>>> +             dev_err(rtk_phy->dev, "%s Error phy_debug_root is NULL",
>>> +                         __func__);
>>> +             return;
>>> +     }
>>> +     rtk_phy->debug_dir = debugfs_create_dir(dev_name(rtk_phy->dev),
>>> +                 phy_debug_root);
>>> +     if (!rtk_phy->debug_dir) {
>>> +             dev_err(rtk_phy->dev, "%s Error debug_dir is NULL",
>>> + __func__);
>>
>> Are you sure you run checkpatch on this? Error messages on debugfs are
>> almost always incorrect.
> 
> Yes, I have run checkpatch for patches. 
> Why the message is incorrect?

Because debugfs failures should not cause any error prints. It's debug,
not important.

Do you see anywhere error messages?

Entire debugfs handling code should be silent and even skip all error
checking, as most API is ready for handling previous errors, I think.

> 
>>> +static int get_phy_parameter(struct rtk_usb_phy *rtk_phy,
>>> +         struct device_node *sub_node) {
>>> +     struct device *dev = rtk_phy->dev;
>>> +     struct reg_addr *addr;
>>> +     struct phy_data *phy_data;
>>> +     int ret = 0;
>>> +     int index;
>>> +
>>> +     if (of_property_read_u32(sub_node, "reg", &index)) {
>>> +             dev_err(dev, "sub_node without reg\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     dev_dbg(dev, "sub_node index=%d\n", index);
>>
>> Please drop all simple debug success messages. Linux has already
>> infrastructure for this.
> 
> Can I keep log for dev_dbg?

No, this was dev_dbg and I commented on this to remove it. Keep only
useful debug messages, not hundreds of them in every place.

Best regards,
Krzysztof

