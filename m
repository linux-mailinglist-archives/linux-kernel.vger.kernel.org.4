Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C1741382
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjF1OQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1OQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:16:36 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D66294C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:16:35 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b03fb998c8so2962537fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1687961794; x=1690553794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z+ak1tfKCZNIZzXIY/5+sOd5zzp2Wy+ezW2xEIcA1y8=;
        b=WynYHrL0HvWAWUhJdRcZsXE4P6DX3o74FoGxXhIECdRj6/vvX7aluVDx4gyLEdKkNy
         ujr8l87wVyG7Olz72ZF0roa7JYpdzTfI6RJObB2AEx5V33FSa1GiDQV44VQaEpRrjK3L
         Mg7fQVgwuIglgCtqUBUsRtzzll4KuCRbVaMFxBYRTk1BrvhSptciQzBSPlIVQqJwzGNa
         atj7XuePPdJRwKhB5Hz4+2tzDS+UlUEWGNkEqP9t599vi96sLkBkC0g8Rz2FHfnW0ykG
         vMZyLzbqjXDfpVHICYAX2ulVuF/bb0JJqvPECgKXI8+NpRPQ6A9tkb4q+I+HiOZi9fGy
         lcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687961794; x=1690553794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+ak1tfKCZNIZzXIY/5+sOd5zzp2Wy+ezW2xEIcA1y8=;
        b=StbsOYvoAv6aE3WBMt8jK3gmXKgQbg/W2BBHupcCbL5Vis8pL9P++YZDl7go+886A7
         gB8xMN0K0fI22quWnNufN50ii/94dvqLlT3dP0AlCSjjnTE2mYR5BhNjBuaKhiD1qb49
         JgW50zv0U3IJaofgyzKFkgkUsvwKBRFnkeVgC1oETiiCSFhJh5GDbeRzxVVWqyZGEami
         f/ZaJY/9j2+xapeCL8y9OuNyUdSF4gK+fN07BE5KnNHJRLfyXt9kPID85bfhMRQ6dQDh
         EASBVFdQvNZoRuej14axnC/iW53q7ucibT1HAF0gyWcEii0KIIoGYBEZnQXgSLl6mg3Q
         tprg==
X-Gm-Message-State: AC+VfDwRFI4Ilesbi0/qlUnX7ax5AIxthvGvOjGfNyzBVgYDzM2BqMS5
        5OzBCDGi1sSUWzNCAjxVzZ93Tg==
X-Google-Smtp-Source: ACHHUZ7Xnj7rY9ffjwsBdfO0XCNxA7UX1GgdadsNm4CFx3OaYZQfCJ+fvvaZ8uSbHmc7ID43O0F0ng==
X-Received: by 2002:a05:6871:507:b0:1b0:372e:e2df with SMTP id s7-20020a056871050700b001b0372ee2dfmr8176010oal.40.1687961794534;
        Wed, 28 Jun 2023 07:16:34 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:c623::7a9])
        by smtp.gmail.com with ESMTPSA id eb9-20020ad44e49000000b006263c531f61sm5748927qvb.24.2023.06.28.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:16:33 -0700 (PDT)
Message-ID: <50b19811444fd2e21751c1ac647312fd9445f623.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: add helper function to get id name
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 28 Jun 2023 10:16:32 -0400
In-Reply-To: <20230613091408.7676-1-ming.qian@nxp.com>
References: <20230613091408.7676-1-ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 13 juin 2023 =C3=A0 17:14 +0800, Ming Qian a =C3=A9crit=C2=A0:
> convert numbers into meaningful names,
> then it can improve the log readability
>=20
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

This will be useful in few months when everyone will have forgot the meanin=
g of
these numbers.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

thanks,
Nicolas

> ---
>  drivers/media/platform/amphion/vdec.c        |  9 +--
>  drivers/media/platform/amphion/vpu.h         |  3 +
>  drivers/media/platform/amphion/vpu_cmds.c    | 11 ++--
>  drivers/media/platform/amphion/vpu_dbg.c     |  6 +-
>  drivers/media/platform/amphion/vpu_helpers.c | 61 ++++++++++++++++++++
>  drivers/media/platform/amphion/vpu_msgs.c    |  2 +-
>  6 files changed, 79 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platfo=
rm/amphion/vdec.c
> index 56c4deea4494..60f3a73c6a8a 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -299,7 +299,8 @@ static int vdec_update_state(struct vpu_inst *inst, e=
num vpu_codec_state state,
>  		vdec->state =3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE;
> =20
>  	if (inst->state !=3D pre_state)
> -		vpu_trace(inst->dev, "[%d] %d -> %d\n", inst->id, pre_state, inst->sta=
te);
> +		vpu_trace(inst->dev, "[%d] %s -> %s\n", inst->id,
> +			  vpu_codec_state_name(pre_state), vpu_codec_state_name(inst->state))=
;
> =20
>  	if (inst->state =3D=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
>  		vdec_handle_resolution_change(inst);
> @@ -1037,8 +1038,8 @@ static int vdec_response_frame(struct vpu_inst *ins=
t, struct vb2_v4l2_buffer *vb
>  		return -EINVAL;
>  	}
> =20
> -	dev_dbg(inst->dev, "[%d] state =3D %d, alloc fs %d, tag =3D 0x%x\n",
> -		inst->id, inst->state, vbuf->vb2_buf.index, vdec->seq_tag);
> +	dev_dbg(inst->dev, "[%d] state =3D %s, alloc fs %d, tag =3D 0x%x\n",
> +		inst->id, vpu_codec_state_name(inst->state), vbuf->vb2_buf.index, vdec=
->seq_tag);
>  	vpu_buf =3D to_vpu_vb2_buffer(vbuf);
> =20
>  	memset(&info, 0, sizeof(info));
> @@ -1400,7 +1401,7 @@ static void vdec_abort(struct vpu_inst *inst)
>  	struct vpu_rpc_buffer_desc desc;
>  	int ret;
> =20
> -	vpu_trace(inst->dev, "[%d] state =3D %d\n", inst->id, inst->state);
> +	vpu_trace(inst->dev, "[%d] state =3D %s\n", inst->id, vpu_codec_state_n=
ame(inst->state));
> =20
>  	vdec->aborting =3D true;
>  	vpu_iface_add_scode(inst, SCODE_PADDING_ABORT);
> diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platfor=
m/amphion/vpu.h
> index 3bfe193722af..5a701f64289e 100644
> --- a/drivers/media/platform/amphion/vpu.h
> +++ b/drivers/media/platform/amphion/vpu.h
> @@ -355,6 +355,9 @@ void vpu_inst_record_flow(struct vpu_inst *inst, u32 =
flow);
>  int vpu_core_driver_init(void);
>  void vpu_core_driver_exit(void);
> =20
> +const char *vpu_id_name(u32 id);
> +const char *vpu_codec_state_name(enum vpu_codec_state state);
> +
>  extern bool debug;
>  #define vpu_trace(dev, fmt, arg...)					\
>  	do {								\
> diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/pl=
atform/amphion/vpu_cmds.c
> index fa581ba6bab2..647d94554fb5 100644
> --- a/drivers/media/platform/amphion/vpu_cmds.c
> +++ b/drivers/media/platform/amphion/vpu_cmds.c
> @@ -98,7 +98,7 @@ static struct vpu_cmd_t *vpu_alloc_cmd(struct vpu_inst =
*inst, u32 id, void *data
>  	cmd->id =3D id;
>  	ret =3D vpu_iface_pack_cmd(inst->core, cmd->pkt, inst->id, id, data);
>  	if (ret) {
> -		dev_err(inst->dev, "iface pack cmd(%d) fail\n", id);
> +		dev_err(inst->dev, "iface pack cmd %s fail\n", vpu_id_name(id));
>  		vfree(cmd->pkt);
>  		vfree(cmd);
>  		return NULL;
> @@ -125,14 +125,14 @@ static int vpu_session_process_cmd(struct vpu_inst =
*inst, struct vpu_cmd_t *cmd)
>  {
>  	int ret;
> =20
> -	dev_dbg(inst->dev, "[%d]send cmd(0x%x)\n", inst->id, cmd->id);
> +	dev_dbg(inst->dev, "[%d]send cmd %s\n", inst->id, vpu_id_name(cmd->id))=
;
>  	vpu_iface_pre_send_cmd(inst);
>  	ret =3D vpu_cmd_send(inst->core, cmd->pkt);
>  	if (!ret) {
>  		vpu_iface_post_send_cmd(inst);
>  		vpu_inst_record_flow(inst, cmd->id);
>  	} else {
> -		dev_err(inst->dev, "[%d] iface send cmd(0x%x) fail\n", inst->id, cmd->=
id);
> +		dev_err(inst->dev, "[%d] iface send cmd %s fail\n", inst->id, vpu_id_n=
ame(cmd->id));
>  	}
> =20
>  	return ret;
> @@ -149,7 +149,8 @@ static void vpu_process_cmd_request(struct vpu_inst *=
inst)
>  	list_for_each_entry_safe(cmd, tmp, &inst->cmd_q, list) {
>  		list_del_init(&cmd->list);
>  		if (vpu_session_process_cmd(inst, cmd))
> -			dev_err(inst->dev, "[%d] process cmd(%d) fail\n", inst->id, cmd->id);
> +			dev_err(inst->dev, "[%d] process cmd %s fail\n",
> +				inst->id, vpu_id_name(cmd->id));
>  		if (cmd->request) {
>  			inst->pending =3D (void *)cmd;
>  			break;
> @@ -339,7 +340,7 @@ static int vpu_session_send_cmd(struct vpu_inst *inst=
, u32 id, void *data)
> =20
>  exit:
>  	if (ret)
> -		dev_err(inst->dev, "[%d] send cmd(0x%x) fail\n", inst->id, id);
> +		dev_err(inst->dev, "[%d] send cmd %s fail\n", inst->id, vpu_id_name(id=
));
> =20
>  	return ret;
>  }
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/pla=
tform/amphion/vpu_dbg.c
> index 44b830ae01d8..adc523b95061 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -67,7 +67,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *d=
ata)
>  	num =3D scnprintf(str, sizeof(str), "tgig =3D %d,pid =3D %d\n", inst->t=
gid, inst->pid);
>  	if (seq_write(s, str, num))
>  		return 0;
> -	num =3D scnprintf(str, sizeof(str), "state =3D %d\n", inst->state);
> +	num =3D scnprintf(str, sizeof(str), "state =3D %s\n", vpu_codec_state_n=
ame(inst->state));
>  	if (seq_write(s, str, num))
>  		return 0;
>  	num =3D scnprintf(str, sizeof(str),
> @@ -188,9 +188,9 @@ static int vpu_dbg_instance(struct seq_file *s, void =
*data)
> =20
>  		if (!inst->flows[idx])
>  			continue;
> -		num =3D scnprintf(str, sizeof(str), "\t[%s]0x%x\n",
> +		num =3D scnprintf(str, sizeof(str), "\t[%s] %s\n",
>  				inst->flows[idx] >=3D VPU_MSG_ID_NOOP ? "M" : "C",
> -				inst->flows[idx]);
> +				vpu_id_name(inst->flows[idx]));
>  		if (seq_write(s, str, num)) {
>  			mutex_unlock(&inst->core->cmd_lock);
>  			return 0;
> diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media=
/platform/amphion/vpu_helpers.c
> index 019c77e84514..af3b336e5dc3 100644
> --- a/drivers/media/platform/amphion/vpu_helpers.c
> +++ b/drivers/media/platform/amphion/vpu_helpers.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include "vpu.h"
> +#include "vpu_defs.h"
>  #include "vpu_core.h"
>  #include "vpu_rpc.h"
>  #include "vpu_helpers.h"
> @@ -447,3 +448,63 @@ int vpu_find_src_by_dst(struct vpu_pair *pairs, u32 =
cnt, u32 dst)
> =20
>  	return -EINVAL;
>  }
> +
> +const char *vpu_id_name(u32 id)
> +{
> +	switch (id) {
> +	case VPU_CMD_ID_NOOP: return "noop";
> +	case VPU_CMD_ID_CONFIGURE_CODEC: return "configure codec";
> +	case VPU_CMD_ID_START: return "start";
> +	case VPU_CMD_ID_STOP: return "stop";
> +	case VPU_CMD_ID_ABORT: return "abort";
> +	case VPU_CMD_ID_RST_BUF: return "reset buf";
> +	case VPU_CMD_ID_SNAPSHOT: return "snapshot";
> +	case VPU_CMD_ID_FIRM_RESET: return "reset firmware";
> +	case VPU_CMD_ID_UPDATE_PARAMETER: return "update parameter";
> +	case VPU_CMD_ID_FRAME_ENCODE: return "encode frame";
> +	case VPU_CMD_ID_SKIP: return "skip";
> +	case VPU_CMD_ID_FS_ALLOC: return "alloc fb";
> +	case VPU_CMD_ID_FS_RELEASE: return "release fb";
> +	case VPU_CMD_ID_TIMESTAMP: return "timestamp";
> +	case VPU_CMD_ID_DEBUG: return "debug";
> +	case VPU_MSG_ID_RESET_DONE: return "reset done";
> +	case VPU_MSG_ID_START_DONE: return "start done";
> +	case VPU_MSG_ID_STOP_DONE: return "stop done";
> +	case VPU_MSG_ID_ABORT_DONE: return "abort done";
> +	case VPU_MSG_ID_BUF_RST: return "buf reset done";
> +	case VPU_MSG_ID_MEM_REQUEST: return "mem request";
> +	case VPU_MSG_ID_PARAM_UPD_DONE: return "param upd done";
> +	case VPU_MSG_ID_FRAME_INPUT_DONE: return "frame input done";
> +	case VPU_MSG_ID_ENC_DONE: return "encode done";
> +	case VPU_MSG_ID_DEC_DONE: return "frame display";
> +	case VPU_MSG_ID_FRAME_REQ: return "fb request";
> +	case VPU_MSG_ID_FRAME_RELEASE: return "fb release";
> +	case VPU_MSG_ID_SEQ_HDR_FOUND: return "seq hdr found";
> +	case VPU_MSG_ID_RES_CHANGE: return "resolution change";
> +	case VPU_MSG_ID_PIC_HDR_FOUND: return "pic hdr found";
> +	case VPU_MSG_ID_PIC_DECODED: return "picture decoded";
> +	case VPU_MSG_ID_PIC_EOS: return "eos";
> +	case VPU_MSG_ID_FIFO_LOW: return "fifo low";
> +	case VPU_MSG_ID_BS_ERROR: return "bs error";
> +	case VPU_MSG_ID_UNSUPPORTED: return "unsupported";
> +	case VPU_MSG_ID_FIRMWARE_XCPT: return "exception";
> +	case VPU_MSG_ID_PIC_SKIPPED: return "skipped";
> +	}
> +	return "<unknown>";
> +}
> +
> +const char *vpu_codec_state_name(enum vpu_codec_state state)
> +{
> +	switch (state) {
> +	case VPU_CODEC_STATE_DEINIT: return "initialization";
> +	case VPU_CODEC_STATE_CONFIGURED: return "configured";
> +	case VPU_CODEC_STATE_START: return "start";
> +	case VPU_CODEC_STATE_STARTED: return "started";
> +	case VPU_CODEC_STATE_ACTIVE: return "active";
> +	case VPU_CODEC_STATE_SEEK: return "seek";
> +	case VPU_CODEC_STATE_STOP: return "stop";
> +	case VPU_CODEC_STATE_DRAIN: return "drain";
> +	case VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE: return "resolution chang=
e";
> +	}
> +	return "<unknown>";
> +}
> diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/pl=
atform/amphion/vpu_msgs.c
> index 92672a802b49..f9eb488d1b5e 100644
> --- a/drivers/media/platform/amphion/vpu_msgs.c
> +++ b/drivers/media/platform/amphion/vpu_msgs.c
> @@ -210,7 +210,7 @@ static int vpu_session_handle_msg(struct vpu_inst *in=
st, struct vpu_rpc_event *m
>  		return -EINVAL;
> =20
>  	msg_id =3D ret;
> -	dev_dbg(inst->dev, "[%d] receive event(0x%x)\n", inst->id, msg_id);
> +	dev_dbg(inst->dev, "[%d] receive event(%s)\n", inst->id, vpu_id_name(ms=
g_id));
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(handlers); i++) {
>  		if (handlers[i].id =3D=3D msg_id) {

