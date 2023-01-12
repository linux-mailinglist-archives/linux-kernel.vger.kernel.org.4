Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600F66783D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjALOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbjALOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:55:19 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B7B81;
        Thu, 12 Jan 2023 06:42:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r130so15436063oih.2;
        Thu, 12 Jan 2023 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FfiRb099in49r1nwfPAks76d0CirkogB3n/rVFHP0Pw=;
        b=Ysn5Pt32e9qLN4c0NnwNeuHcsuMZUUADmet3ZSOAox+Lzi7Kaf+2BWN4GRfkWHI+mg
         dCke0xXWMhVvDjjzaHqycxuPKaMT6IOE71HPXvjV4Yu0S+oV1ZzJ2fgVGw5dq4E3LDiN
         l1JrmFsedjqPnGoAMKfbOIFIT99ZcbnHLpgGWTb2AQxwqDw3DlkIGcYJQKVo/pglte1R
         Pn3XmZxdlad9YToIgKEoubZ57xYEjTclj4VJ+APOi1LaneS9a03xqCtmtsxRB2XfrHQJ
         THC4BfrBqK0HwX3l7hAZbOdg0ubl0Ipq285Rc+4cbl365qJuLI1NXsajZQ3v/Hx8lHg/
         wz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfiRb099in49r1nwfPAks76d0CirkogB3n/rVFHP0Pw=;
        b=a8n6S92tvlF7W/WU59pA15BajQBv+tWkvg88GCwzv2W5d/7l9MClH0MHjrG3ssMzqw
         zDViOm3j0Nf7HtRgu5ZM1cJjuN79wzDtNQSfgesPEiqAQ4BMcsrRf1zKW96FdCCtF1oA
         lKoC3ZUH1rFVqvuZbElNUIqvXNedu2mOHr3ALtsGnHbpcnfkAlajatOWvm96r3Ae/XHk
         O+ifYWmeVtaCAOqFC7IBJsz85moJ1Kc5fVQgTWkNRypqakMcKqwMXeteNHUaBCfzYQWX
         PrUQ6CoOYi0hGcKdPjL+TZ3CNXov7JIoT96wCoHkVhRWeuZc9HjbFJK6IRssmv6G9FJT
         lXjg==
X-Gm-Message-State: AFqh2koANyiAMJm+U0rgraekmnWT0jZrj8ZOGb3jb+11rScm9pdoHO/g
        FvO63ENgmCEWfZ7J6Cie5tA=
X-Google-Smtp-Source: AMrXdXtDa867UjawrzMQJa7AxbLvsYaJzCbQw+rUDqVgvIMPc5zdk9sjxeX5Nb6tC9fEPL2ZLm1+0w==
X-Received: by 2002:aca:1914:0:b0:35e:d286:2317 with SMTP id l20-20020aca1914000000b0035ed2862317mr34543758oii.25.1673534528477;
        Thu, 12 Jan 2023 06:42:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d590b000000b00677714a440fsm9188192oth.81.2023.01.12.06.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:42:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <05d5e1fb-fb49-fc3e-802b-5e7bacd97dc2@roeck-us.net>
Date:   Thu, 12 Jan 2023 06:42:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20221223102122.1038499-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221223102122.1038499-1-badhri@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/22 02:21, Badhri Jagan Sridharan wrote:
> On some of the TCPC implementations, when the Type-C port is exposed
> to contaminants, such as water, TCPC stops toggling while reporting OPEN
> either by the time TCPM reads CC pin status or during CC debounce
> window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> to restart toggling, the behavior recurs causing redundant CPU wakeups
> till the USB-C port is free of contaminant.
> 
> [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> 
> (or)
> 
> [ 7853.867577] Start toggling
> [ 7853.889921] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7855.698765] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> [ 7855.698790] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7855.698826] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [ 7855.703559] CC1: 0 -> 0, CC2: 5 -> 5 [state SNK_ATTACH_WAIT, polarity 0, connected]
> [ 7855.856555] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
> [ 7855.856581] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7855.856613] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
> [ 7856.027744] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
> [ 7856.181949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7856.187896] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7857.645630] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7857.647291] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> [ 7857.647298] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7857.647310] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [ 7857.808106] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
> [ 7857.808123] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7857.808150] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
> [ 7857.978727] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
> 
> To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
> can implement the check_contaminant callback which is invoked by TCPM
> to evaluate for presence of contaminant. Lower level TCPC driver can
> restart toggling through TCPM_PORT_CLEAN event when the driver detects
> that USB-C port is free of contaminant. check_contaminant callback also passes
> the disconnect_while_debounce flag which when true denotes that the CC pins
> transitioned to OPEN state during the CC debounce window.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v10:
> * Fall back to default state if enabling toggling fails when
> * exiting CHECK_CONTAMINANT state
> Changes since v9:
> * Invoke tcpm_start_toggling before transitioning to TOGGLING from
> * CHECK_CONTAMINANT.
> Changes since v7:
> * None. Skipped versions by mistake.
> Changes since v6:
> * folded the debounce logic into tcpm state machine and removed tcpm
> * state export.
> * Added a helper to determine whether the port is in toggling state.
> * Excluded CHECK_CONTAMINANT from tcpm_log.
> Changes since v5:
> * Updated commit message. Removed change id.
> Changes since v4:
> * None
> Changes since v3:
> * None
> Changes since V2:
> * Offloaded tcpm from maintaining disconnect_while_debouncing logic
> * to lower level maxim tcpc driver based on feedback.
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 55 ++++++++++++++++++++++++++++++++++-
>   include/linux/usb/tcpm.h      |  8 +++++
>   2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 904c7b4ce2f0..c624747f32df 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -36,6 +36,7 @@
>   #define FOREACH_STATE(S)			\
>   	S(INVALID_STATE),			\
>   	S(TOGGLING),			\
> +	S(CHECK_CONTAMINANT),			\
>   	S(SRC_UNATTACHED),			\
>   	S(SRC_ATTACH_WAIT),			\
>   	S(SRC_ATTACHED),			\
> @@ -249,6 +250,7 @@ enum frs_typec_current {
>   #define TCPM_RESET_EVENT	BIT(2)
>   #define TCPM_FRS_EVENT		BIT(3)
>   #define TCPM_SOURCING_VBUS	BIT(4)
> +#define TCPM_PORT_CLEAN		BIT(5)
>   
>   #define LOG_BUFFER_ENTRIES	1024
>   #define LOG_BUFFER_ENTRY_SIZE	128
> @@ -483,6 +485,13 @@ struct tcpm_port {
>   	 * SNK_READY for non-pd link.
>   	 */
>   	bool slow_charger_loop;
> +
> +	/*
> +	 * When true indicates that the lower level drivers indicate potential presence
> +	 * of contaminant in the connector pins based on the tcpm state machine
> +	 * transitions.
> +	 */
> +	bool potential_contaminant;
>   #ifdef CONFIG_DEBUG_FS
>   	struct dentry *dentry;
>   	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -647,7 +656,7 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
>   	/* Do not log while disconnected and unattached */
>   	if (tcpm_port_is_disconnected(port) &&
>   	    (port->state == SRC_UNATTACHED || port->state == SNK_UNATTACHED ||
> -	     port->state == TOGGLING))
> +	     port->state == TOGGLING || port->state == CHECK_CONTAMINANT))
>   		return;
>   
>   	va_start(args, fmt);
> @@ -3904,15 +3913,28 @@ static void run_state_machine(struct tcpm_port *port)
>   	unsigned int msecs;
>   	enum tcpm_state upcoming_state;
>   
> +	if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
> +		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
> +						port->state == SRC_UNATTACHED) ||
> +					       (port->enter_state == SNK_ATTACH_WAIT &&
> +						port->state == SNK_UNATTACHED));
> +
>   	port->enter_state = port->state;
>   	switch (port->state) {
>   	case TOGGLING:
>   		break;
> +	case CHECK_CONTAMINANT:
> +		port->tcpc->check_contaminant(port->tcpc);
> +		break;
>   	/* SRC states */
>   	case SRC_UNATTACHED:
>   		if (!port->non_pd_role_swap)
>   			tcpm_swap_complete(port, -ENOTCONN);
>   		tcpm_src_detach(port);
> +		if (port->potential_contaminant) {
> +			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
> +			break;
> +		}
>   		if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
>   			tcpm_set_state(port, TOGGLING, 0);
>   			break;
> @@ -4150,6 +4172,10 @@ static void run_state_machine(struct tcpm_port *port)
>   			tcpm_swap_complete(port, -ENOTCONN);
>   		tcpm_pps_complete(port, -ENOTCONN);
>   		tcpm_snk_detach(port);
> +		if (port->potential_contaminant) {
> +			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
> +			break;
> +		}
>   		if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
>   			tcpm_set_state(port, TOGGLING, 0);
>   			break;
> @@ -4926,6 +4952,9 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>   		else if (tcpm_port_is_sink(port))
>   			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
>   		break;
> +	case CHECK_CONTAMINANT:
> +		/* Wait for Toggling to be resumed */
> +		break;
>   	case SRC_UNATTACHED:
>   	case ACC_UNATTACHED:
>   		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
> @@ -5425,6 +5454,15 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
>   			port->vbus_source = true;
>   			_tcpm_pd_vbus_on(port);
>   		}
> +		if (events & TCPM_PORT_CLEAN) {
> +			tcpm_log(port, "port clean");
> +			if (port->state == CHECK_CONTAMINANT) {
> +				if (tcpm_start_toggling(port, tcpm_rp_cc(port)))
> +					tcpm_set_state(port, TOGGLING, 0);
> +				else
> +					tcpm_set_state(port, tcpm_default_state(port), 0);
> +			}
> +		}
>   
>   		spin_lock(&port->pd_event_lock);
>   	}
> @@ -5477,6 +5515,21 @@ void tcpm_sourcing_vbus(struct tcpm_port *port)
>   }
>   EXPORT_SYMBOL_GPL(tcpm_sourcing_vbus);
>   
> +void tcpm_port_clean(struct tcpm_port *port)
> +{
> +	spin_lock(&port->pd_event_lock);
> +	port->pd_events |= TCPM_PORT_CLEAN;
> +	spin_unlock(&port->pd_event_lock);
> +	kthread_queue_work(port->wq, &port->event_work);
> +}
> +EXPORT_SYMBOL_GPL(tcpm_port_clean);
> +
> +bool tcpm_port_is_toggling(struct tcpm_port *port)
> +{
> +	return port->port_type == TYPEC_PORT_DRP && port->state == TOGGLING;
> +}
> +EXPORT_SYMBOL_GPL(tcpm_port_is_toggling);
> +
>   static void tcpm_enable_frs_work(struct kthread_work *work)
>   {
>   	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index bffc8d3e14ad..ab7ca872950b 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -114,6 +114,11 @@ enum tcpm_transmit_type {
>    *              Optional; The USB Communications Capable bit indicates if port
>    *              partner is capable of communication over the USB data lines
>    *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> + * @check_contaminant:
> + *		Optional; The callback is called when CC pins report open status
> + *		at the end of the deboumce period or when the port is still
> + *		toggling. Chip level drivers are expected to check for contaminant
> + *		and call tcpm_clean_port when the port is clean.
>    */
>   struct tcpc_dev {
>   	struct fwnode_handle *fwnode;
> @@ -148,6 +153,7 @@ struct tcpc_dev {
>   						 bool pps_active, u32 requested_vbus_voltage);
>   	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>   	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
> +	void (*check_contaminant)(struct tcpc_dev *dev);
>   };
>   
>   struct tcpm_port;
> @@ -165,5 +171,7 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>   			       enum tcpm_transmit_status status);
>   void tcpm_pd_hard_reset(struct tcpm_port *port);
>   void tcpm_tcpc_reset(struct tcpm_port *port);
> +void tcpm_port_clean(struct tcpm_port *port);
> +bool tcpm_port_is_toggling(struct tcpm_port *port);
>   
>   #endif /* __LINUX_USB_TCPM_H */
> 
> base-commit: 6feb57c2fd7c787aecf2846a535248899e7b70fa

