Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A777D6CF29D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjC2TAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjC2TAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:00:21 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA9359B;
        Wed, 29 Mar 2023 12:00:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 106A15C01A3;
        Wed, 29 Mar 2023 15:00:20 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 29 Mar 2023 15:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680116420; x=1680202820; bh=Xs
        HOmOpJLWFvPCA5G9Wa28HScvgjlpZob2jqot0Wt5Q=; b=ZB+OVrcs765Jx9p2C0
        VBhFvGTUFPaAbO1PvuISpriBWEBofHCckTEKwlOsPxItTxPuiGdUGMRBUG6WbFuK
        2M1CoKn9A65HNGrTvbbJMZM4TOJ4oVNt15m+5b8R1csbBuYSYdDYtv2LuIG626iE
        1xVpghI8cqW3D3sabedzxjbDMPXmAQIYGuR10HPPCBUvZwVqRFZOQ+ZA5y0IaY/k
        4N4L1a3NVWU753ag5d2jRsK73AADpEhEIibiswDLWkvkl3yEGzohxkaZakkc8e9c
        d/oRn/r6UO2tw2GQII3b22LS1vFbdj/vVEBdrMGN45hv0UlwbtkI6XSVNsnZE6eO
        98kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680116420; x=1680202820; bh=XsHOmOpJLWFvP
        CA5G9Wa28HScvgjlpZob2jqot0Wt5Q=; b=klPUu94Y8NqmzjrXFeYA+pY3OEJs7
        zQ0sHRePDM/7AzfnvKNKwd0nEMNKJ7++RAcl7PM0cuGGIDTkpeiIr4BQ8rWMx7F5
        BtZ1bqO6FxInx/TRh41g8TZAxmWcrER20wC3ChU3Q3/7b4QFBiyJWveQllklFe5e
        AZ9NwkpTjyY/dIqJa2OxKd/2k6zEfGLkLX67qJRpkndnWr5F0EdhQ9h748P976dP
        ASu01sa62JafRxG9JA7LeXjLCVqNu76GnV099it675pWmhfdFXoWBVhZTxLuj73U
        eRWhDHg6KdMmjgALVTQ/eB9q//WbXQ1rKmeBzQ5rV1imIqUnsyv60UYyg==
X-ME-Sender: <xms:w4okZPW1lF0KLbcjktjWBzTa7jT7j2QXlw87V8RrzSnLixY5E5fE1A>
    <xme:w4okZHmzne8Q3BFteLdxbzQVBWNAepdegn8giKvda17yCARDuuxbfASCqYKyWounV
    FiYj68I2yjIbF3jKXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:w4okZLZ4UA7pJqE2LB58ndru6MZKBGV8XY3DO0NayouJhpZStiryRQ>
    <xmx:w4okZKVVYsVSVm-fXeiYwrE82tD2GFSFJ9GZh9OLHyuZ1x_9zlItGA>
    <xmx:w4okZJl5MKr7Ha53K28RKwmuInE-hw9su76IQeEtu9zOcgLIYJnt2Q>
    <xmx:xIokZHaCn-rRixbswUSjJ-UpuB6Og9yYwszJCqs-iz1ocU4UyZGv7g>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27B93C60091; Wed, 29 Mar 2023 15:00:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <b06d1d1f-7cd5-4532-ac49-d449ef68bbcb@app.fastmail.com>
In-Reply-To: <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <ZCLPaYGKHlFQGKYQ@kroah.com>
 <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr>
 <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr>
 <ZCLa3_HnLQA0GQKS@kroah.com>
 <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr>
 <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de>
 <16862c45-2ffd-a2f2-6719-020c5d515800@alu.unizg.hr>
 <4f65a23f-4e04-f04f-e56b-230a38ac5ec4@gmx.de>
 <01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr>
 <8b478e6d-7482-2cbb-ee14-b2dc522daf35@alu.unizg.hr>
 <9f757a7b-6ac9-804a-063f-4cc2c6fc3f54@alu.unizg.hr>
 <de54f828-e2c6-4c10-92ce-ca86fb5c5fb4@t-8ch.de>
 <6a5dc4de-b315-1e6d-e5e2-5b95521a37c7@alu.unizg.hr>
 <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com>
 <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com>
 <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr>
Date:   Wed, 29 Mar 2023 14:59:54 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     "Armin Wolf" <W_Armin@gmx.de>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [BUG] [RFC] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mirsad

On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
<snip>
>
> Here is the patch proposal according to what Mark advised (using 
> different name for optitem):
>
> diff --git a/drivers/platform/x86/think-lmi.c 
> b/drivers/platform/x86/think-lmi.c
> index c816646eb661..ab17254781c4 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject 
> *kobj, struct kobj_attribute *a
>
>          /* validate and split from `item,value` -> `value` */
>          value = strpbrk(item, ",");
> -       if (!value || value == item || !strlen(value + 1))
> +       if (!value || value == item || !strlen(value + 1)) {
> +               kfree(item);
>                  return -EINVAL;
> +       }
>
>          ret = sysfs_emit(buf, "%s\n", value + 1);
>          kfree(item);
> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting 
> *tlmi_create_auth(const char *pwd_type,
>
>   static int tlmi_analyze(void)
>   {
> -       acpi_status status;
>          int i, ret;
>
>          if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>                  char *p;
>
>                  tlmi_priv.setting[i] = NULL;
> -               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> -               if (ACPI_FAILURE(status))
> +               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> +               if (ret)

Really minor, but tweak to be this and save a line of code?
+               if (tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID))

>                          break;
>                  if (!item)
>                          break;
> @@ -1457,10 +1458,10 @@ static int tlmi_analyze(void)
>                           * name string.
>                           * Try and pull that out if it's available.
>                           */
> -                       char *item, *optstart, *optend;
> +                       char *optitem, *optstart, *optend;
>
> -                       if (!tlmi_setting(setting->index, &item, 
> LENOVO_BIOS_SETTING_GUID)) {
> -                               optstart = strstr(item, "[Optional:");
> +                       if (!tlmi_setting(setting->index, &optitem, 
> LENOVO_BIOS_SETTING_GUID)) {
> +                               optstart = strstr(optitem, 
> "[Optional:");
>                                  if (optstart) {
>                                          optstart += 
> strlen("[Optional:");
>                                          optend = strstr(optstart, "]");
> @@ -1469,6 +1470,7 @@ static int tlmi_analyze(void)
>                                                          
> kstrndup(optstart, optend - optstart,
>                                                                         
>  GFP_KERNEL);
>                                  }
> +                               kfree(optitem);
>                          }
>                  }
>                  /*
>
> I have tested it, but without a few blunders of my own.

I'm running a build locally and will aim to put this thru a few different platforms myself too and sanity check

> I guess "nobody wins them all".

I hear you :P

Mark
