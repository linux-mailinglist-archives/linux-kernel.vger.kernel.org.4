Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12D744B19
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 22:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGAU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGAU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 16:59:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE78D127;
        Sat,  1 Jul 2023 13:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKPUqv5T2VMwO6sIBRBV4opZ8jN70vSPktkya4+IiAxJgpxCwADthjwFoMoYEkj5GtPcbnknJ4PINsZgzkR3FMGstV6NGOsBDnUZ/WYRmbqjvLOjvmGDy3cCmD3iQz16RYGdX/RMIgggJaCZgjesvlyfpCRXalf4qKyGd6Ymeh6kEaY6OWHoV9PZQF1yY8qznPvlfcw3vg+oUUEp/VlQxTowF0WBgDKSZsLpxQP3rB9PtA5i5gUfhJGNIVVTC4QvpWHizTn9LIElnnxtQRvb+u3oah9CtfPr5N82wmdt5CH2or6ZO5OLDHB8ZZttwti8KQhSwrVaeBpxMZ2g++tGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=donxME4aqb8ZHi702vqxBDf2C9ma9eoxLdKciKtoKMc=;
 b=jkxW0N5jZ1paSRGKzaLOkE9Dk1IBUHp0C76ka+F6gXVvHvhkkGlFpqC38pEYnJPgAWQvcZJPjk8E3u55r7NClmZvJZPNsB8wbK/W4OybUf4ymac8c/TYc3YjytuUJ1hebHlTwKmCgDpeS1N+zgaIy8zCFRTycF/NtTDttTqqNVUmjQnqQx1CdGlun8AmRre4Rz4tgtZmlvsSDBjZpqx7qJyh+ky+zGc1oMEFKI0v37o6TofI4/rBcjbzGYq7Jpt8bX9psaS0/Xoe0HQvtttkaXjElFEK8a2drtLAhGdRmrWBqOW7rq7cK02wGQAWXLvjf/XxTjEToTQQ9UApdr0dJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=donxME4aqb8ZHi702vqxBDf2C9ma9eoxLdKciKtoKMc=;
 b=BRojP72U1lMoOuF5f8wG1yKsJPvirs2iiZ2f3pfGI4Zx2zVA0d5likbnPl40Z7js8/Tq/7kZbvQnRSedKA1KALZDUAOmwSI/fVv5uQZKLoBu5NS4ePQhL5Mf1aUYK5ytZ1XfsWO3w4iiTdN6gni++aqbGwp/KooGRXxYdQlfbC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV2PR08MB8026.eurprd08.prod.outlook.com (2603:10a6:150:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 20:58:58 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 20:58:58 +0000
Message-ID: <ed1f627b-1713-b273-c083-c98d88f885d2@wolfvision.net>
Date:   Sat, 1 Jul 2023 22:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay object
 handling
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZJj5VcHvfMMWMRx8@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:802:1::15) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV2PR08MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 473dc346-2817-407d-96a4-08db7a75fd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SecWXpWtYvUk76eeS607mc/h66VRzIXvNTJx5DeVOH9VocL5WR/qyQhiWhZc6KEowXife68axinEJ1Bc1Vw35aXePuvQLh65itQMuyrpLOKoWytNt5rHIIfYavo2dgGNkXMak/WrRgbVxaRCDh8VJAwR9baLEJOYxJayYJZdWK9UVkisMuY1xLOKo4kib6eU7J1a67kl9kJkGOOzj7RdJ+x2wNmBMyKjx2OwE9acnNLzRXShGz52bjG5DPVX7SJ8nO7bN8eiaGfUdXIpE85+Ck8APVmRYr6jc5cU/HDqVP/X/AjnVmO5XUv/NPxyPUV9AJrdw3bBGIe305QYrgPqhg2M6cMRuyAU+2z1/CEOba3VSYzUMI/AxrdnVCzkZIP4djtuyBaD5NghJUJzUkGI4M0kat1JJh8mpTGKHEoiq2+kOEag5e2rtmLMpsbKbezV4JJAcQ8lKJk7cF5+vazbozstEjzUhEu90VzVGOuC8WpreG7izZPeYN5VaNRw8ufhKzSGOVEUFsZFQAsOKRPclg9qTw0dbl1Ph/Xu5TV2YRCL8XMS6iXuyXBoCCe7GHOHALKONF+frifdaDUughgW860xWZvk3cG2FW1iRnU6f3uYpcF+GzGVvUM6VuO0Ayg15hmbaR1sI1wqG3JjtRYBKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39830400003)(376002)(346002)(136003)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(7416002)(36756003)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(6506007)(6512007)(6666004)(53546011)(6486002)(316002)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3QxU3FLN3I3SUhqYlhOWWtpbWNSNWN6K1BNOUNTUGdObTNRODBsK3cza2hl?=
 =?utf-8?B?S3hyT1N3L2V6cG5MYWZCNHNRVjQvS0VDemxRcC9EeWZ2VUZ6d1dZdkFBa082?=
 =?utf-8?B?ZzlDNHYrOS9NWU1NUU9oZGYwcDdzdkxLZ2xrRUZna3BZUTNxdVdwcGhuVUcv?=
 =?utf-8?B?YVlITEJKRS9ieVlET1BTTHBBOWRIbDZlVkNCaUY0bC9Kb21yU0VSdmdKR1Mr?=
 =?utf-8?B?czVuSDM5ZkVialBjV2NoOXhIR0lwbE1pVC9TRTI0VUE2N1hCeHoxb2NaVm1k?=
 =?utf-8?B?T3BZSDVuaWhuK0x1YW5zK0RqMDFhM0UwUHFLaFpMaU5PSmVkanBUOFBUSk5i?=
 =?utf-8?B?dGN0cURyUG1XSUVBMnFEOU91VkNzWnd2S1NBdjlxQnlvOU5oUmk0bGJxSFVE?=
 =?utf-8?B?YkVqdlVZNlpzVExOQ3dXendvaVBleFhWbmt4QTV0T3ZkYUlzRVlZdnZ2ZVNK?=
 =?utf-8?B?VXNXMW53enRUNHdFSEZTY3lOSmZYRTJrdEM2a3luUS93M3g1V3B2SXk4bjJC?=
 =?utf-8?B?VHJCL0xsbG9jdlFna3BPUGg2dk5yOGRRaEtXeitZUmxPcHNKSXRDSFlXSUVC?=
 =?utf-8?B?aHhDZmQ3cUJra1ZrREoyWnpyTEdhM2d0WUxnWmE3cDlGKzR2UUU2UUQ5Umow?=
 =?utf-8?B?NzJ0ZW4rS1ZWc2hrTXNCU3U4WFdzajlWUUYvWUxrRmYrRVNhdzVJTTZvWUl4?=
 =?utf-8?B?bDVETEMrakNNVnNyMDIvaFZnSnZIVEUwNk03djNsL3RxTDdia3VDdU94dU5k?=
 =?utf-8?B?V1I0eHMra3JSOFNBZk82TkEydnJlSTVHdERrR3ZqaGVPS29KNk0vbzNFOUlr?=
 =?utf-8?B?dXNTTEVrWFNGWXkvUTcxWUozM1IzMmlxRkgxeWxyeHRlUW1Nb3d5NGZhU29Q?=
 =?utf-8?B?WlZpTGZVYVdLSmI3ZkM2dTRGQ3pOV3JtbGEvT2tHMGN0T1pmaXhRRTVFOUxR?=
 =?utf-8?B?ZVpBcDd0bk44Ti9DajlNYjZIWnRiWkVOV3JEc0lxMFE5b3NLeWV0ZXBjNWgz?=
 =?utf-8?B?L2xCOXEyd3NWUnQ0cEdlUSt1MEk2Z0RLaDFrRTlWQTdJTlFHRUphUE5DUTlw?=
 =?utf-8?B?eS84ZUNLQVJHN0lKQk1wTjlQNUxHWlhPeTBrbEVpekZSR2c3M0YzbU15Z1pu?=
 =?utf-8?B?amI4K1VJZUdGZEJVOXpWb3pxOHVzSTJNeGtrUzZSUng1bXZnRzZtN1NkVkhM?=
 =?utf-8?B?TGM0YjBVUjZJcGUxa05sNWJzenZSVEQvRXdheHhralI5LzROQ0hmbytyeXhK?=
 =?utf-8?B?dFZWRnRpbUlQSUp2dFJHUEt6N3lmZWt1VE9EdURvUnJwWms3WkhYY2lKQ1Jy?=
 =?utf-8?B?MVplYzlXUmtEVk4zU3JNN1RBK2JQemdCQlR5VUtxZFkzaW14ODk2eFl1THMx?=
 =?utf-8?B?ZDgwVVlCK3RjTXhWM0svQ3QvcEdTUmRDSnJSYmZ1WWR5UjcrelZ6SWE2cy9u?=
 =?utf-8?B?ci8rTHZEOENCMmUrS0gzb3AxUGVEWWxFaFRLMWVXTGRmdEhiV1czOGh6aWU0?=
 =?utf-8?B?M0ZGVDRnUzkzZTFaenNXNzFQeVlUR3ZwSWY1TWFrSkg3M1BNSmZVbnZVM3Vz?=
 =?utf-8?B?RENBeDZKZXpubk51c2NjV0ZZMHV3LzJDRmYxNjJrOHQ3eG5kVVpsaG55YldE?=
 =?utf-8?B?TUcxeURwTGI4Nzg2YU9nV2Fna2JjMGZ6aGRJMTR4Wk14UmdPYy9QU3ZxL3pv?=
 =?utf-8?B?TUFuNkdnLzZKUm5xR2s2MUdTaDNkS20yODlHUW1TUlhCcktvbmt2WXNNbkt4?=
 =?utf-8?B?eEROLzIrOWk0cjQyU2tKRHZ4VWF0NGFSRXRRd1NVUGQwNi9BVEVzWnBKVHlZ?=
 =?utf-8?B?ZlRsNUx6TEdJL0dNMDFySkZ0dmtSZGJtd3NaQWF6U21ndlM3UjIvNURRQ1Zp?=
 =?utf-8?B?bWVtaWNSTWh5cnE4dC9tSTdZODdlbXhBRVlWcVdEWWt5QktWT3NvN252cHA3?=
 =?utf-8?B?OHNaUUJNVUNwZW5OTFVaVnlKTnp4VHc5MzFDS1JiVC93cUxsb1J1VW9OUXZj?=
 =?utf-8?B?RngzU2d0aXZhUWh6UE1XTDJJUkc3bnhNTVI3MVpaSDVaYUZiYzVPY3NPYWNt?=
 =?utf-8?B?eUVpRnRtWUhQS1dvTFNtQ3MxWXMrdlNsWlllM2UyZnV3bDBDZExJMjlLckFV?=
 =?utf-8?B?Ty9qdXNabU11USthZkVvS0g4aitQcTJSOHhYY2UyOFpUdUFBYUIydDN5Zmhw?=
 =?utf-8?B?RjZzSjRwTTgvVUg0OUlkaXdqSmtsb1p4akw4VW5VeFBTU2J4VjhxT0ZqOXdQ?=
 =?utf-8?Q?TpRDnOuV6OHufaVJG15TqkQMLlQtnOdVX4dXk8b594=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 473dc346-2817-407d-96a4-08db7a75fd17
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 20:58:58.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQbOPn72E+NRp4SIqwGJeHA+gsvX77HYE+PrwEHCTgDO5N6ks/Upv4pGuHQ0MqcqkDmKewNCVRaAm4EkEuQ6ybwv6pLsDoqQS3GpIP32KnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8026
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 26.06.23 04:35, Jeff LaBundy wrote:
>> +
>> +		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
>> +			 btn[j].shape.x_origin, btn[j].shape.y_origin,
>> +			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
> 
> This seems like a dev_dbg() to me.
> 
>> +		j++;
>> +	}
>> +
>> +	return 0;
>> +
>> +button_prop_cleanup:
>> +	fwnode_handle_put(child_btn);
>> +	return rc;
>> +}
>> +
>> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
>> +				struct input_dev *dev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < map->button_count; i++)
>> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
>> +}
>> +EXPORT_SYMBOL(ts_overlay_set_button_caps);
> 
> I don't see a need to expose this function and require participating drivers
> to call it; we should just have one over-arching function for processing the
> overlay(s), akin to touchscreen_parse_properties but for the button input
> device in case the driver separates the button and touchscreen input devices.
> 
> That one function would then be responsible for parsing the overlay(s) and
> calling input_set_capability() on each button.
> 
I just realized that I did not reply anything about this, even though
there is a reason why I exposed this function and now that I am working
on the v4, some clarification might be required.

After it was decided that this feature should work with two different
devices (a touchscreen and a keypad), I registered a keypad in the
st1232.c probe function if overlay buttons were defined. I did not
register the device inside the new functions because I thought that I
would be hiding too much magic from the driver.

Instead I provided a function to check if a keypad was defined and
another one to set the capabilities (the one we are discussing). The
driver could just set any parameters it wants before registering the
device and use this function within that process. The parsing is not
missing, it is carried out before and the programmer does not need to
know the key capabilities to call this function.

So the process is as follows:
1.- Map overlay objects if they are defined.
2.- If there is a keypad, set the device properties you want it to have
(name, etc). The event keys were already parsed and can be set with
touch_overlay_set_button_caps()
3.- Register the device whenever and under the circumstances you like.

That is the current implementation, not necessarily the best one or the
one the community would prefer.
If that is preferred, the mapping function could for example register
the keypad and return a pointer to the keyboard, inferring the device
properties from the "main" device that will be registered anyways (e.g.
using its name + "-keypad") or passing them as parameters, which might
look a bit artificial. In that case the key capabilities would be
automatically set and this function would not be exposed any more.

The question is if we would be missing flexibility when setting the
device properties prior its registration and if the participating
drivers want this to be done under the hood. My solution is the one I
found less intrusive for the driver (at the cost of doing the
registration itself), but if there are good reasons for a different
implementation, I will be alright with it. If not, the driver will
control the keypad registration and will use this function to set the
key caps.

Sorry for the late reply to this particular point and especially for the
long text. But a clarification here might save us from another
discussion later on :)

Best regards,
Javier Carrasco
